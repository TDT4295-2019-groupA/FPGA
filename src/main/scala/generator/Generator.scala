package generator

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util.{Counter, is, switch}
import state.{Envelope, PitchWheelArray}

class Generator extends MultiIOModule{

  val MIDI_A3_FREQ = 440.0
  val MIDI_A3_INDEX = 45
  val SAMPLE_RATE = 44100
  val SAMPLE_MAX: SInt = 0x7FFF.S
  val VELOCITY_MAX: UInt = 0x7f.U

  val io = IO(
    new Bundle {
      val generatorPacketIn = Input(new GeneratorPacket)

      val envelopeIn = Input(new Envelope)
      val pitchWheelArrayIn = Input(new PitchWheelArray)
      val writeEnable = Input(Bool())

      val sampleOut = Output(SInt(16.W))
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
    MIDI_A3_FREQ * scala.math.pow(2.0, (note_index - MIDI_A3_INDEX) / 12.0)

  def freq_to_wavelength_in_samples(freq: Double): Double =
    scala.math.round(SAMPLE_RATE / freq)

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

  val inst = io.generatorPacketIn.instrument // shortname
  when(inst === InstrumentEnum.SQUARE) {
    when (((noteLife.asSInt() * 2.S) / wavelength) % 2.S === 1.S) {
      saved_sample := SAMPLE_MAX * (-1).S
    } otherwise {
      saved_sample := SAMPLE_MAX
    }
  }
  when(inst === InstrumentEnum.TRIANGLE) {
    saved_sample := 0.S
  }
  when(inst === InstrumentEnum.SAWTOOTH) {
    saved_sample := ((((noteLife % wavelength.asUInt()) * 2.S) - wavelength) * SAMPLE_MAX) / wavelength
  }
  when(inst === InstrumentEnum.SINE) {
    saved_sample := 0.S
  }

  when(enabled) {
    io.sampleOut := (saved_sample * (velocity / VELOCITY_MAX))
  } otherwise {
    io.sampleOut := 0.S
  }

  printf("Inputs: Enabled: %b, Instrument: %d, Note_Index: %d, Channel_Index: %d, Velocity: %d, Reset_Note: %b\n", io.generatorPacketIn.enabled, io.generatorPacketIn.instrument, io.generatorPacketIn.note_index, io.generatorPacketIn.channel_index, io.generatorPacketIn.velocity, io.generatorPacketIn.reset_note)
  printf("Instrument: %d, Enabled: %b, Note_Index: %d, WriteEnable: %b, InstrumentEnumSquare: %d, Velocity: %d, Notelife: %d\n", instrument, enabled, note_index, io.writeEnable, InstrumentEnum.SQUARE, velocity, noteLife)
  printf("Saved_Sample: %d, Velocity_Max: %d, Velocity: %d\n", saved_sample, VELOCITY_MAX, velocity)
  //printf("PackageIn: %d\n", io.generatorPacketIn.asUInt())
  //printf("SampleMax: %d, VelocityMax: %d\n", SAMPLE_MAX.toUInt, VELOCITY_MAX.toUInt)
  //printf("VelocityIn:%d\n", io.generatorPacketIn.velocity)
}

object InstrumentEnum extends Enumeration {
  type InstrumentEnum = UInt
  val SQUARE: UInt = 0.U
  val TRIANGLE: UInt = 1.U
  val SAWTOOTH: UInt = 2.U
  val SINE: UInt = 3.U
}
