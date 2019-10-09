package generator

import chisel3._
import config.config
import chisel3.experimental.MultiIOModule
import chisel3.util.{Counter, is, switch}
import state.{Envelope, PitchWheelArray}

class Generator extends MultiIOModule{

  val io = IO(
    new Bundle {
      val generatorPacketIn = Input(new GeneratorPacket)

      val envelopeIn = Input(new Envelope)
      val pitchWheelArrayIn = Input(new PitchWheelArray)
      val writeEnable = Input(Bool())

      val sampleOut = Output(SInt(24.W))
    }
  )
  val noteLife = RegInit(UInt(32.W), 0.U)
  val enabled = RegInit(Bool(), false.B)
  val instrument = RegInit(UInt(8.W), InstrumentEnum.SQUARE)
  val note_index = RegInit(UInt(8.W), 0.U)
  val velocity = RegInit(UInt(8.W), 64.U)

  val lookupTable = Reg(Vec(128, SInt(32.W)))

  for (i <- 0 to 127) {
    lookupTable(i) := freq_to_wavelength_in_samples(fpga_note_index_to_freq(i)).toInt.S
  }

  def fpga_note_index_to_freq(note_index: Int): Double =
    config.MIDI_A3_FREQ * scala.math.pow(2.0, (note_index - config.MIDI_A3_INDEX) / 12.0)

  def freq_to_wavelength_in_samples(freq: Double): Double =
    scala.math.round(config.SAMPLE_RATE / freq)

  val saved_sample = RegInit(SInt(16.W), 0.S)

  when(io.writeEnable) {
    enabled := io.generatorPacketIn.enabled
    instrument := io.generatorPacketIn.instrument
    note_index := io.generatorPacketIn.note_index
    velocity := io.generatorPacketIn.velocity
  }


  when(io.writeEnable && io.generatorPacketIn.reset_note) {
    noteLife := 0.U
  } otherwise {
    noteLife := noteLife + 1.U
  }

  val wavelength: SInt = lookupTable(note_index)

  when(instrument === InstrumentEnum.SQUARE) {
    when (((noteLife << 1).asSInt() / wavelength)(0).asSInt() === 1.S) {
      saved_sample := (-config.SAMPLE_MAX).S
    } otherwise {
      saved_sample := config.SAMPLE_MAX.S
    }
  }
  when(instrument === InstrumentEnum.TRIANGLE) {
    saved_sample := 0.S
  }
  when(instrument === InstrumentEnum.SAWTOOTH) {
    saved_sample := ((((noteLife % wavelength.asUInt()) << 1).asSInt() - wavelength) * config.SAMPLE_MAX.S) / wavelength
  }
  when(instrument === InstrumentEnum.SINE) {
    saved_sample := 0.S
  }

  when(enabled) {
    io.sampleOut := saved_sample * velocity.asSInt()
  } otherwise {
    io.sampleOut := 0.S
  }
}

// todo: move to config.scala?
object InstrumentEnum extends Enumeration {
  type InstrumentEnum = UInt
  val SQUARE: UInt = 0.U
  val TRIANGLE: UInt = 1.U
  val SAWTOOTH: UInt = 2.U
  val SINE: UInt = 3.U
}
