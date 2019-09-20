package generator

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util.{Counter, is, switch}
import state.{Envelope, PitchWheelArray}

class Generator extends MultiIOModule{

  val MIDI_A3_FREQ = 440.0
  val MIDI_A3_INDEX = 45
  val SAMPLE_RATE = 44100
  val SAMPLE_MAX: UInt = 0x7FFF.U
  val VELOCITY_MAX: UInt = 0x7f.U

  val io = IO(
    new Bundle {
      val generatorPacketIn = Input(new GeneratorPacket)
      val envelopeIn = Input(new Envelope)
      val pitchWheelArrayIn = Input(new PitchWheelArray)
      val writeEnable = Input(Bool())

      val sampleOut = Output(UInt(16.W))
    }
  )
  val noteLife = RegInit(UInt(32.W), 0.U)
  val enabled = RegInit(Bool(), false.B)
  val instrument = RegInit(UInt(8.W), InstrumentEnum.SQUARE)
  val note_index = RegInit(UInt(8.W), 0.U)
  val velocity = RegInit(UInt(8.W), 0.U)

  val lookupTable = Reg(Vec(128, UInt(32.W)))

  for (i <- 0 to 128) {
    lookupTable(i) := freq_to_wavelength_in_samples(fpga_note_index_to_freq(i)).toInt.U
  }

  def fpga_note_index_to_freq(note_index: Int): Double =
    MIDI_A3_FREQ * scala.math.pow(2.0, (note_index - MIDI_A3_INDEX) / 12.0)

  def freq_to_wavelength_in_samples(freq: Double): Double =
    scala.math.round(SAMPLE_RATE / freq)

  val saved_sample = RegInit(UInt(16.W), 0.U)


  when(io.writeEnable) {
    enabled := io.generatorPacketIn.enabled
    instrument := io.generatorPacketIn.instrument
    note_index := io.generatorPacketIn.note_index
    velocity := io.generatorPacketIn.velocity
  }


  when(io.generatorPacketIn.reset_note) {
    noteLife := 0.U
  } otherwise {
    noteLife := noteLife + 1.U
  }

  val wavelength: UInt = lookupTable(note_index)

  // todo: make this back to a switch when we get it to compile
  val inst = io.generatorPacketIn.instrument // shortname
  when(inst === InstrumentEnum.SQUARE) {
    when (((noteLife * 2.U) / wavelength) % 2.U === 1.U) {
      saved_sample := - SAMPLE_MAX
    } otherwise {
      saved_sample := SAMPLE_MAX
    }
  }
  when(inst === InstrumentEnum.TRIANGLE) {
    saved_sample := 0.U
  }
  when(inst === InstrumentEnum.SAWTOOTH) {
    saved_sample := ((((noteLife % wavelength) * 2.U) - wavelength) * SAMPLE_MAX) / wavelength
  }
  when(inst === InstrumentEnum.SINE) {
    saved_sample := 0.U
  }

  when(enabled) {
    io.sampleOut := (saved_sample * velocity) / VELOCITY_MAX
  } otherwise {
    io.sampleOut := 0.U
  }



}

object InstrumentEnum extends Enumeration {
  type InstrumentEnum = UInt
  val SQUARE: UInt = 0.U
  val TRIANGLE: UInt = 1.U
  val SAWTOOTH: UInt = 2.U
  val SINE: UInt = 3.U
}
