package sadie.generator

import chisel3._
import chisel3.util._
import chisel3.experimental.MultiIOModule
import envelope.EnvelopeImpl
import instruments.{Sawtooth, Sine, Square, Triangle}
import sadie.communication._
import sadie.config.config

class Generator extends MultiIOModule{
  val io = IO(
    new Bundle {
      val generator_update_valid = Input(Bool()) // pulsed for one cycle
      val generator_update       = Input(new GeneratorUpdate)
      val generator_num          = Input(UInt())
      val global_config          = Input(new GlobalUpdate) // assumed always valid
      val step_sample            = Input(Bool()) // pulsed for one cycle
      val sample_out             = Output(SInt(32.W))
    }
  )

  // Generator State
  val note_life        = RegInit(UInt(32.W), 0.U) // time passed since start of note counted in samples
  val wavelength_pos   = RegInit(UInt(32.W), 0.U) // time passed since start of note counted in samples, mod wavelength
  val generator_config = RegInit(new GeneratorUpdate, 0.U.asTypeOf(new GeneratorUpdate))

  // LUTs
  def fpga_note_index_to_freq(note_index: Int): Double =
    math.round((1 << config.FREQ_SHIFT) * config.MIDI_A3_FREQ * math.pow(2.0, (note_index - config.MIDI_A3_INDEX) / 12.0))

  def freq_to_wavelength_in_samples(freq: UInt): UInt = {
    val temp_value = config.SAMPLE_RATE << config.FREQ_SHIFT
    (temp_value * config.NOTE_LIFE_COEFF).asUInt() / freq
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

  note_remainder := generator_config.note_index % 12.U
  note_divide    := generator_config.note_index / 12.U

  freq_base := DontCare

  for (i <- 0 to 11) {
    when(note_remainder === i.U) {
      // we go up 16 octaves to avoid rounding errors
      freq_base := BigDecimal(fpga_note_index_to_freq(i + 12*16)).toBigInt().U << note_divide >> 16.U
      //freq_base := (fpga_note_index_to_freq(i + 12*16)).toInt.U << note_divide >> 16.U
    }
  }


  val magic_linear_scale = 59.S //((math.pow(2.0, 2.0 / 12.0) - math.pow(2.0, -2.0 / 12.0)) * (1 << 8)).toInt = 59.2802
  val magic_linear_offset = 65536.S //(1 << 16)
  freq_coeff := ((io.global_config.pitchwheels(generator_config.channel_index)
    * magic_linear_scale)
    + magic_linear_offset).asUInt()

  freq := ((freq_base * freq_coeff) >> 16).asUInt()

  val wavelength = freq_to_wavelength_in_samples(freq)

  // handle input
  when (io.generator_update_valid) {
    generator_config := io.generator_update
    when (io.generator_update.reset_note) {
      note_life := 0.U
      wavelength_pos := 0.U
    }
  }
  when (io.step_sample) {
    note_life      := note_life + config.NOTE_LIFE_COEFF.U
    when (wavelength_pos + 1.U >= wavelength) {
      wavelength_pos := wavelength_pos + config.NOTE_LIFE_COEFF.U - wavelength
    } otherwise {
      wavelength_pos := wavelength_pos + config.NOTE_LIFE_COEFF.U
    }
  }

  val current_sample = Wire(SInt(32.W))
  current_sample := 0.S

  val square = Module(new Square()).io
  square.wavelength       := wavelength
  square.wavelength_pos   := wavelength_pos
  square.note_life        := note_life

  val triangle = Module(new Triangle()).io
  triangle.wavelength     := wavelength
  triangle.wavelength_pos := wavelength_pos
  triangle.note_life      := note_life

  val sawtooth = Module(new Sawtooth()).io
  sawtooth.wavelength     := wavelength
  sawtooth.wavelength_pos := wavelength_pos
  sawtooth.note_life      := note_life

  val sine = Module(new Sine()).io
  sine.wavelength         := wavelength
  sine.wavelength_pos     := wavelength_pos
  sine.note_life          := note_life

  switch (generator_config.instrument) {
    is (config.InstrumentEnum.SQUARE) {
      current_sample := square.sample_out
    }
    is (config.InstrumentEnum.TRIANGLE) {
      current_sample := triangle.sample_out
    }
    is (config.InstrumentEnum.SAWTOOTH) {
      current_sample := sawtooth.sample_out
    }
    is (config.InstrumentEnum.SINE) {
      current_sample := sine.sample_out
    }
  }

  val last_active_envelope_effect = RegInit(UInt(16.W), 0.U)
  val envelope_impl = Module(new EnvelopeImpl()).io

  envelope_impl.note_life                   := note_life
  envelope_impl.envelope                    := io.global_config.envelope
  envelope_impl.last_active_envelope_effect := last_active_envelope_effect
  envelope_impl.enabled                     := generator_config.enabled

  when(generator_config.enabled){
    last_active_envelope_effect := envelope_impl.envelope_effect
  }

  //io.sample_out := current_sample * generator_config.velocity
  io.sample_out := ((current_sample * envelope_impl.envelope_effect) >> 16.U) *  generator_config.velocity.asSInt()

  if (false) {
    when((io.generator_num === 1.U || io.generator_num === 2.U) && false.B) {
      printf("Gen %d: wavelength: %d, freq: %d, freq_base %d, freq_coeff: %d, note_life: %d, instrument: %d\n", io.generator_num, wavelength, freq, freq_base, freq_coeff, note_life, generator_config.instrument)
      printf("Note: %d, Wavelength_pos: %d, note_remainder: %d, note_divide: %d, \n", generator_config.note_index, wavelength_pos, note_remainder, note_divide)
      printf("Enabled: %d, Current_Sample: %d, Last_Env_Effect: %d, Sample Out: %d, Velocity: %d\n", generator_config.enabled, current_sample, last_active_envelope_effect, io.sample_out, generator_config.velocity)
      printf("Current_Sample: %d, Envelope_Effect: %d, Velocity: %d, Enabled: %d\n", current_sample, envelope_impl.envelope_effect, generator_config.velocity, generator_config.enabled)
    }
  }
}
