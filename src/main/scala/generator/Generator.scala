package sadie.generator

import chisel3._
import chisel3.util._
import chisel3.experimental.MultiIOModule
import envelope.EnvelopeImpl
import instruments.{Sawtooth, Sine, Square, Triangle}
import sadie.communication._
import sadie.config.config

class GeneratorStateBundle extends Bundle {
  val generator_config            = new GeneratorUpdate
  val note_life                   = UInt(32.W)
  val wavelength                  = UInt(32.W)
  val wavelength_pos              = UInt(32.W)
  val last_active_envelope_effect = UInt(16.W)
}

class GeneratorStateHandler extends MultiIOModule {
  val io = IO(
    new Bundle {
      val generator_update_valid = Input(Bool()) // pulsed for one cycle
      val generator_update       = Input(new GeneratorUpdate)
      val global_config          = Input(new GlobalUpdate) // assumed always valid
      val step_sample            = Input(Bool()) // pulsed for one cycle

      val envelope_effect_valid  = Input(Bool())
      val envelope_effect        = Input(UInt(16.W))

      val state                  = Output(new GeneratorStateBundle)
    }
  )

  val state = RegInit(new GeneratorStateBundle, 0.U.asTypeOf(new GeneratorStateBundle))
  io.state := state

  when(io.envelope_effect_valid && state.generator_config.enabled) {
    state.last_active_envelope_effect := io.envelope_effect
    // todo: verify that the envelope release works
  }


  // LUTs
  def fpga_note_index_to_freq(note_index: Int): Double =
    math.round((1 << config.FREQ_SHIFT) * config.MIDI_A3_FREQ * math.pow(2.0, (note_index - config.MIDI_A3_INDEX) / 12.0))

  def freq_to_wavelength_in_samples(freq: UInt): UInt = {
    val temp_value = BigInt(config.SAMPLE_RATE) << config.FREQ_SHIFT
    (temp_value * config.NOTE_LIFE_COEFF).U / freq
    //We do this because it is currently too big to be an int :( By a very small margin btw
    //28901376000L.U / freq
  }

  /*
  Here we can save a lot of space for some computation.
  Every 12th step in the note_index is roughly equal to half the previous one
  ie: step 25 = step 13 / 2
  By using modulo for index and dividing for range, we can reduce the size from 128 to 12
  This increases computational complexity, but hopefully reduces space necessary
   */

  val note_remainder: UInt = Wire(UInt(16.W))
  val note_divide   : UInt = Wire(UInt(16.W))
  val freq          : UInt = Wire(UInt(32.W))
  val freq_base     : UInt = Wire(UInt(32.W))
  val freq_coeff    : UInt = Wire(UInt(32.W))

  note_remainder := state.generator_config.note_index % 12.U
  note_divide    := state.generator_config.note_index / 12.U

  freq_base := DontCare
  for (i <- 0 to 11) {
    when(note_remainder === i.U) {
      // we go up 16 octaves to avoid rounding errors
      freq_base := BigDecimal(fpga_note_index_to_freq(i + 12*16)).toBigInt().U << note_divide >> 16.U
      //freq_base := (fpga_note_index_to_freq(i + 12*16)).toInt.U << note_divide >> 16.U
    }
  }

  val magic_linear_scale = 59.S // ((math.pow(2.0, 2.0 / 12.0) - math.pow(2.0, -2.0 / 12.0)) * (1 << 8)).toInt = 59.2802
  val magic_linear_offset = (1 << 16).S
  freq_coeff := ((io.global_config.pitchwheels(state.generator_config.channel_index)
    * magic_linear_scale)
    + magic_linear_offset).asUInt()

  if (!config.MinimalMode) {
    freq := (freq_base * freq_coeff) >> 16.U
  } else {
    freq := freq_base
  }

  state.wavelength := freq_to_wavelength_in_samples(freq)

  // handle input
  when (io.generator_update_valid) {
    state.generator_config := io.generator_update
    when (io.generator_update.reset_note) {
      state.note_life      := 0.U
      state.wavelength_pos := 0.U
    }
  }
  when (io.step_sample) {
    state.note_life := state.note_life + config.NOTE_LIFE_COEFF.U
    when (state.wavelength_pos + 1.U >= state.wavelength) {
      if (config.MinimalMode) {
        state.wavelength_pos := 0.U
      } else {
        state.wavelength_pos := state.wavelength_pos + config.NOTE_LIFE_COEFF.U - state.wavelength
      }
    } otherwise {
      state.wavelength_pos := state.wavelength_pos + config.NOTE_LIFE_COEFF.U
    }
  }
}


class GeneratorSampleComputer extends MultiIOModule {
  val io = IO(
    new Bundle {
      val state         = Input(new GeneratorStateBundle)
      val global_config = Input(new GlobalUpdate) // assumed always valid
      val sample_out      = Output(SInt(32.W))
      val envelope_effect = Output(UInt(16.W))
    }
  )

  io.sample_out := 0.S

  if (!config.MinimalMode) {
  // === NON-MINIMAL VERSION BEGIN ===

  val square   = Module(new Square()).io
  val triangle = Module(new Triangle()).io
  val sawtooth = Module(new Sawtooth()).io
  val sine     = Module(new Sine()).io
  for (i <- Array(square, triangle, sawtooth, sine)) {
    i.wavelength     := io.state.wavelength
    i.wavelength_pos := io.state.wavelength_pos
    i.note_life      := io.state.note_life
  }

  val current_sample = Wire(SInt(32.W))
  current_sample := 0.S
  switch (io.state.generator_config.instrument) {
    is (config.InstrumentEnum.SQUARE)   { current_sample := square.sample_out }
    is (config.InstrumentEnum.TRIANGLE) { current_sample := triangle.sample_out }
    is (config.InstrumentEnum.SAWTOOTH) { current_sample := sawtooth.sample_out }
    is (config.InstrumentEnum.SINE)     { current_sample := sine.sample_out }
  }

  val envelope_impl = Module(new EnvelopeImpl()).io
  envelope_impl.note_life                   := io.state.note_life
  envelope_impl.envelope                    := io.global_config.envelope
  envelope_impl.last_active_envelope_effect := io.state.last_active_envelope_effect
  envelope_impl.enabled                     := io.state.generator_config.enabled

  io.envelope_effect := envelope_impl.envelope_effect
  when (io.state.generator_config.enabled) {
    io.sample_out := ((current_sample * envelope_impl.envelope_effect) >> 16.U) * io.state.generator_config.velocity.asSInt()
  }


  // === NON-MINIMAL VERSION END ===
  } else {
  // === MINIMAL VERSION BEGIN ===


  io.envelope_effect := 0xffff.U // gets optimized away by dead code elimination, but must be driven to compile

  val square   = Module(new Square()).io
  square.wavelength     := io.state.wavelength
  square.wavelength_pos := io.state.wavelength_pos
  square.note_life      := io.state.note_life
  when (io.state.generator_config.enabled) {
    io.sample_out := square.sample_out * io.state.generator_config.velocity.asSInt()
  }

  } // === MINIMAL VERSION END ===
}
