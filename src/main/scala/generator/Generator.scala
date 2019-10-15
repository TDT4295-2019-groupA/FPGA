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

  val square = Module(new Square()).io
  square.wavelength := wavelength
  square.wavelength_pos := wavelength_pos
  square.note_life := note_life

  val triangle = Module(new Triangle()).io
  triangle.wavelength := wavelength
  triangle.wavelength_pos := wavelength_pos
  triangle.note_life := note_life

  val sawtooth = Module(new Sawtooth()).io
  sawtooth.wavelength := wavelength
  sawtooth.wavelength_pos := wavelength_pos
  sawtooth.note_life := note_life

  val sine = Module(new Sine()).io
  sine.wavelength := wavelength
  sine.wavelength_pos := wavelength_pos
  sine.note_life := note_life

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

  envelope_impl.note_life := note_life
  envelope_impl.envelope := io.global_config.envelope
  envelope_impl.last_active_envelope_effect := last_active_envelope_effect
  envelope_impl.enabled := generator_config.enabled

  when(generator_config.enabled){
    last_active_envelope_effect := envelope_impl.envelope_effect
  }

  io.sample_out := ((current_sample * envelope_impl.envelope_effect.asSInt()).asSInt() >> 16).asSInt() *  generator_config.velocity.asSInt()

}
