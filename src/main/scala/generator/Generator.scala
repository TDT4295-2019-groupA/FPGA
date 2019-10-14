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

  val lookup_value_array = new Array[(UInt, UInt)](12)
  val note_remainder: UInt = Wire(UInt())
  val note_divide: UInt = Wire(UInt())

  note_remainder := generator_config.note_index % 12.U
  note_divide := generator_config.note_index / 12.U

  for (i <- 0 until 12) {
    lookup_value_array(i) = i.U -> freq_to_wavelength_in_samples(fpga_note_index_to_freq(i)).toInt.U
  }

  val wavelength = (MuxLookup(note_remainder, 0.U (32.W), lookup_value_array) >> note_divide).asUInt()

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
  switch (generator_config.instrument) {
    is (config.InstrumentEnum.SQUARE) {
      when ((wavelength_pos << 1).asUInt() > wavelength) {
        current_sample := (-config.SAMPLE_MAX).S
      } otherwise {
        current_sample := config.SAMPLE_MAX.S
      }
    }
    is (config.InstrumentEnum.TRIANGLE) {
      val half = Wire(UInt())
      val quarter = Wire(UInt())
      val pos = Wire(UInt())

      half := wavelength_pos >>1
      quarter := wavelength_pos >>2

      when(wavelength_pos > (half + quarter)) {
        pos := wavelength_pos - (half + quarter)
      }.otherwise {
        pos := wavelength_pos + quarter
      }
      current_sample := ((pos - half).asUInt() - quarter).asSInt() * config.SAMPLE_MAX.asSInt() / quarter.asSInt()
    }
    is (config.InstrumentEnum.SAWTOOTH) {
      current_sample := ((((wavelength_pos) << 1) - wavelength) * config.SAMPLE_MAX.S) / wavelength.asSInt()
    }
    is (config.InstrumentEnum.SINE) {

      //See: https://en.wikipedia.org/wiki/Bhaskara_I%27s_sine_approximation_formula

      val angleValue = Wire(SInt())
      angleValue := 2.S * 314.S * note_life / wavelength.asSInt()
      current_sample := config.SAMPLE_MAX.asSInt() * ((4.S * angleValue * (180.S - angleValue)) / (40500.S - angleValue * (180.S - angleValue))).asSInt()
    }
  }

  /*
  Here is the envelope implementation. It is taken pretty directly from the reference implementation
   */
  val envelope = io.global_config.envelope
  val life = Wire(UInt(32.W))
  val scaled_sustain = Wire(UInt(16.W))
  val envelope_effect = Wire(UInt(16.W))
  val last_active_envelope_effect = RegInit(UInt(16.W), 0.U)

  life := note_life / config.NOTE_LIFE_COEFF.U
  scaled_sustain := (envelope.sustain << 8).asUInt() | envelope.sustain

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

  io.sample_out := ((current_sample * envelope_effect.asSInt()).asSInt() >> 16).asSInt() *  generator_config.velocity.asSInt()

}
