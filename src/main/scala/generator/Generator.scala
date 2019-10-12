package sadie.generator

import chisel3._
import chisel3.util._
import chisel3.experimental.MultiIOModule
import sadie.communication._
import sadie.config.config

class Generator extends MultiIOModule{
  val io = IO(
    new Bundle {
      val generator_update_valid = Input(Bool()) // pulsed for one cycle
      val generator_update       = Input(new GeneratorUpdate)
      val global_config          = Input(new GlobalUpdate) // assumed always valid
      val step_sample            = Input(Bool()) // pulsed for one cycle
      val sample_out             = Output(SInt(16.W))
    }
  )

  // Generator State
  val note_life       = RegInit(UInt(32.W), 0.U) // time passed since start of note counted in samples
  val wavelength_pos  = RegInit(UInt(32.W), 0.U) // time passed since start of note counted in samples, mod wavelength
  val generator_config = RegInit(new GeneratorUpdate, 0.U.asTypeOf(new GeneratorUpdate))

  // LUTs
  def fpga_note_index_to_freq(note_index: Int): Double =
    config.MIDI_A3_FREQ * scala.math.pow(2.0, (note_index - config.MIDI_A3_INDEX) / 12.0)

  def freq_to_wavelength_in_samples(freq: Double): Double =
    scala.math.round(config.SAMPLE_RATE / freq)


  /*
  Here we can save a lot of space for some computation.
  Every 12th step in the note_index is roughly equal to half the previous one
  ie: step 25 = step 13 / 2
  By using modulo for index and dividing for range, we can reduce the size from 128 to 12
  This increases computational complexity, but hopefully reduces space necessary
   */

  val wavelength_lut = Reg(Vec(12, UInt(32.W)))
  //val wavelength: UInt = wavelength_lut(generator_config.note_index)


  val wavelength: UInt = Wire(UInt())
  for (i <- 0 until 12) {
    wavelength_lut(i) := freq_to_wavelength_in_samples(fpga_note_index_to_freq(i)).toInt.U
  }
  when(generator_config.note_index >= 12.U) {
    wavelength := wavelength_lut(generator_config.note_index % 12.U) >> (generator_config.note_index / 12.U)
  }.otherwise{
    wavelength := wavelength_lut(generator_config.note_index)
  }


  // handle input
  when (io.generator_update_valid) {
    generator_config := io.generator_update
    when (io.generator_update.reset_note) {
      note_life := 0.U
      wavelength_pos := 0.U
    }
  }
  when (io.step_sample) {
    note_life      := note_life + 1.U

    when (wavelength_pos >= wavelength) {
      wavelength_pos := 0.U
    } otherwise {
      wavelength_pos := wavelength_pos + 1.U
    }
  }


  val current_sample = Wire(SInt(16.W))
  current_sample := 0.S

  // todo: get rid of the modulo, see the reference implementation
  // todo: implement other wavetypes (if we have the space)
  switch (generator_config.instrument) {
    is (config.InstrumentEnum.SQUARE) {
      when ((wavelength_pos << 1).asUInt() > wavelength) {
        current_sample := (-config.SAMPLE_MAX).S
      } otherwise {
        current_sample := config.SAMPLE_MAX.S
      }
    }
    is (config.InstrumentEnum.TRIANGLE) {
      current_sample := 0.S
    }
    is (config.InstrumentEnum.SAWTOOTH) {
      //current_sample := ((((wavelength_pos) << 1) - wavelength) * config.SAMPLE_MAX.S) / wavelength.asSInt()
      current_sample := 0.S
    }
    is (config.InstrumentEnum.SINE) {
      current_sample := 0.S
    }
  }

  io.sample_out := current_sample * generator_config.velocity.asSInt() >> 7


  /*
  Here is the envelope implementation. It is taken pretty directly from the reference implementation
  Should not be implemented until we have more space available
  Needs a lot of optimizations wrt approximating instead of calculating, especially division
   */

  //TODO: Start using this (sample_out := (current_sample * envelope_effect) >> 16 * velocity
  /*

  val envelope = io.global_config.envelope
  val life = Wire(UInt(32.W))
  life := note_life / config.NOTE_LIFE_COEFF.U
  val scaled_sustain = Wire(UInt(16.W))
  scaled_sustain := (envelope.sustain << 8).asUInt() | envelope.sustain
  val envelope_effect = Wire(UInt(16.W))
  val last_active_envelope_effect = RegInit(UInt(16.W), 0.U)

  when(!generator_config.enabled) {
  when (life < envelope.release) {
  envelope_effect := last_active_envelope_effect * (envelope.release - life) / envelope.release
  }.otherwise{
    envelope_effect := 0.U
  }
  }.elsewhen(life < envelope.attack) {
    envelope_effect := 0xffff.U * life / envelope.attack
  }.elsewhen(life < envelope.attack + envelope.decay) {
    envelope_effect := (envelope.decay - (life - envelope.attack)) * (0xffff.U - scaled_sustain) / envelope.decay + scaled_sustain
  }.otherwise{
    envelope_effect := scaled_sustain
  }

    when(generator_config.enabled){
    last_active_envelope_effect := envelope_effect
  }
   */

  //printf("valid %d\n", io.generator_update_valid)
  //printf("instrument %d\n", io.generator_update.instrument)
  //printf("instrument %d\n", generator_config.instrument)
  //printf("note_life %d\n", note_life)
  //printf("generator_update_valid %d\n", io.generator_update_valid)
}
