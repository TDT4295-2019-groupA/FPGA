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
    math.round((1 << config.FREQ_SHIFT) * config.MIDI_A3_FREQ * math.pow(2.0, (note_index - config.MIDI_A3_INDEX) / 12.0))

  def freq_to_wavelength_in_samples(freq: UInt): UInt =
    ((config.SAMPLE_RATE << config.FREQ_SHIFT) * config.NOTE_LIFE_COEFF).asUInt() / freq


  /*
  Here we can save a lot of space for some computation.
  Every 12th step in the note_index is roughly equal to half the previous one
  ie: step 25 = step 13 / 2
  By using modulo for index and dividing for range, we can reduce the size from 128 to 12
  This increases computational complexity, but hopefully reduces space necessary
   */

  val lookup_value_array = new Array[(UInt, UInt)](12)
  val note_offset: UInt = Wire(UInt(16.W))
  val note_remainder: UInt = Wire(UInt(16.W))
  val note_divide: UInt = Wire(UInt(16.W))
  val wavelength_base: UInt = Wire(UInt(16.W))
  val freq: UInt = Wire(UInt(16.W))
  val freq_base: UInt = Wire(UInt(16.W))
  val freq_coeff: UInt = Wire(UInt(16.W))

  note_remainder := generator_config.note_index % 12.U
  note_divide := generator_config.note_index / 12.U
  wavelength_base := 0.U


  freq_base := DontCare

  for (i <- 0 until 11) {
    when (note_remainder === i.U) {
      freq_base := (fpga_note_index_to_freq(i).toInt.U >> note_divide).asUInt()
    }
  }

  note_offset := (2.U * io.global_config.pitchwheels(generator_config.channel_index)) / 128.U
  //This is bad and dumb, replace with lookup table
  freq_coeff := (2.U << (note_offset /12.U)).asUInt() * (1 << config.FREQ_SHIFT).asUInt()

  freq := (freq_base * freq_coeff) >> config.FREQ_SHIFT

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
