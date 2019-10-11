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
      val sample_out             = Output(SInt(16.W))
    }
  )

  // Generator State
  val note_life       = RegInit(UInt(32.W), 0.U) // time passed since start of note counted in samples
  val wavelength_pos  = RegInit(UInt(32.W), 0.U) // time passed since start of note counted in samples, mod wavelength
  val generator_config = Reg(new GeneratorUpdate)

  // LUTs
  def fpga_note_index_to_freq(note_index: Int): Double =
    config.MIDI_A3_FREQ * scala.math.pow(2.0, (note_index - config.MIDI_A3_INDEX) / 12.0)

  def freq_to_wavelength_in_samples(freq: Double): Double =
    scala.math.round(config.SAMPLE_RATE / freq)

  val wavelength_lut = Reg(Vec(128, UInt(32.W)))
  for (i <- 0 to 127) {
    wavelength_lut(i) := freq_to_wavelength_in_samples(fpga_note_index_to_freq(i)).toInt.U
  }
  val wavelength: UInt = wavelength_lut(generator_config.note_index)


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
  switch (generator_config.instrument) {
    is (InstrumentEnum.SQUARE) {
      when ((wavelength_pos << 1) > wavelength) {
        current_sample := (-config.SAMPLE_MAX).S
      } otherwise {
        current_sample := config.SAMPLE_MAX.S
      }
    }
    is (InstrumentEnum.TRIANGLE) {
      current_sample := 0.S
    }
    is (InstrumentEnum.SAWTOOTH) {
      //current_sample := ((((wavelength_pos) << 1) - wavelength) * config.SAMPLE_MAX.S) / wavelength.asSInt()
      current_sample := 0.S
    }
    is (InstrumentEnum.SINE) {
      current_sample := 0.S
    }
  }

  //io.sample_out := current_sample * generator_config.velocity.asSInt() / config.VELOCITY_MAX.S
  io.sample_out := current_sample * generator_config.velocity.asSInt() >> 7

  //printf("valid %d\n", io.generator_update_valid)
  //printf("instrument %d\n", io.generator_update.instrument)
  //printf("instrument %d\n", generator_config.instrument)
  //printf("note_life %d\n", note_life)
  //printf("generator_update_valid %d\n", io.generator_update_valid)
}

// todo: move to config.scala?
object InstrumentEnum extends Enumeration {
  type InstrumentEnum = UInt
  val SQUARE: UInt = 0.U
  val TRIANGLE: UInt = 1.U
  val SAWTOOTH: UInt = 2.U
  val SINE: UInt = 3.U
}
