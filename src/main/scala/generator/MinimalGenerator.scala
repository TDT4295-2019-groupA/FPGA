package generator

import chisel3._
import chisel3.util._
import chisel3.experimental.MultiIOModule
import envelope.EnvelopeImpl
import instruments.{Sawtooth, Sine, Square, Triangle}
import sadie.communication._
import sadie.config.config

class MinimalGenerator extends MultiIOModule{
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
  val note_life       = RegInit(UInt(32.W), 0.U) // time passed since start of note counted in samples
  val wavelength_pos  = RegInit(UInt(32.W), 0.U) // time passed since start of note counted in samples, mod wavelength
  val generator_config = RegInit(new GeneratorUpdate, 0.U.asTypeOf(new GeneratorUpdate))

  // LUTs
  def fpga_note_index_to_freq(note_index: Int): Double =
    math.round((1 << config.FREQ_SHIFT) * config.MIDI_A3_FREQ * math.pow(2.0, ((config.MIDI_INDEX_MAX - note_index) - config.MIDI_A3_INDEX) / 12.0))

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
  val note_divide: UInt = Wire(UInt(16.W))
  val freq: UInt = Wire(UInt(32.W))
  val freq_base: UInt = Wire(UInt(32.W))
  val freq_coeff: UInt = Wire(UInt(32.W))

  note_remainder := generator_config.note_index % 12.U
  note_divide := (config.MIDI_INDEX_MAX.U - generator_config.note_index) / 12.U

  freq_base := DontCare

  for (i <- 0 to 11) {
    when(note_remainder === i.U) {
      freq_base := fpga_note_index_to_freq(i).toInt.U >> note_divide
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
    when (wavelength_pos >= wavelength) {
      wavelength_pos := 0.U
    } otherwise {
      wavelength_pos := wavelength_pos + config.NOTE_LIFE_COEFF.U
    }
  }

  val current_sample = Wire(SInt(32.W))
  current_sample := 0.S

  val square = Module(new Square()).io
  square.wavelength := wavelength
  square.wavelength_pos := wavelength_pos
  square.note_life := note_life

  current_sample := square.sample_out

  //io.sample_out := current_sample * generator_config.velocity
  when(generator_config.enabled) {
    io.sample_out := (current_sample  *  generator_config.velocity.asSInt())
  }.otherwise {
    io.sample_out := 0.S
  }

}
