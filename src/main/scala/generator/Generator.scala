package generator

import chisel3._
import chisel3.util._
import config.config
import chisel3.experimental.MultiIOModule
import communication._

class Generator extends MultiIOModule{
  val io = IO(
    new Bundle {
      val generator_update_valid = Input(Bool()) // pulsed for one cycle
      val generator_update       = Input(new GeneratorUpdate)
      val global_config          = Input(new GlobalUpdate) // assumed always valid
      val step_sample            = Input(Bool()) // pulsed for one cycle
      val sample_out             = Output(SInt(24.W))
    }
  )
  // state
  val note_life  = RegInit(UInt(32.W), 0.U)
  val generator_config = Reg(new GeneratorUpdate)

  // handle input
  when (io.generator_update_valid) {
    generator_config := io.generator_update
    when (io.generator_update.reset_note) {
      note_life := 0.U
    }
  }
  when (io.step_sample) {
    note_life := note_life + 1.U
  }

  val lookupTable = Reg(Vec(128, SInt(32.W))) // todo: for what? rename this
  for (i <- 0 to 127) {
    lookupTable(i) := freq_to_wavelength_in_samples(fpga_note_index_to_freq(i)).toInt.S
  }

  def fpga_note_index_to_freq(note_index: Int): Double =
    config.MIDI_A3_FREQ * scala.math.pow(2.0, (note_index - config.MIDI_A3_INDEX) / 12.0)

  def freq_to_wavelength_in_samples(freq: Double): Double =
    scala.math.round(config.SAMPLE_RATE / freq)

  val wavelength: SInt = lookupTable(generator_config.note_index)
  val current_sample = Wire(SInt(16.W))
  current_sample := 0.S

  // todo: get rid of the modulo, see the reference implementation
  switch (generator_config.instrument) {
    is (InstrumentEnum.SQUARE) {
      when (((note_life << 1).asSInt() / wavelength)(0).asSInt() === 1.S) {
        current_sample := (-config.SAMPLE_MAX).S
      } otherwise {
        current_sample := config.SAMPLE_MAX.S
      }
    }
    is (InstrumentEnum.TRIANGLE) {
      current_sample := 0.S
    }
    is (InstrumentEnum.SAWTOOTH) {
      current_sample := ((((note_life % wavelength.asUInt()) << 1).asSInt() - wavelength) * config.SAMPLE_MAX.S) / wavelength
    }
    is (InstrumentEnum.SINE) {
      current_sample := 0.S
    }
  }

  io.sample_out := current_sample * generator_config.velocity.asSInt()
}

// todo: move to config.scala?
object InstrumentEnum extends Enumeration {
  type InstrumentEnum = UInt
  val SQUARE: UInt = 0.U
  val TRIANGLE: UInt = 1.U
  val SAWTOOTH: UInt = 2.U
  val SINE: UInt = 3.U
}
