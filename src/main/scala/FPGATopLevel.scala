package generator

import chisel3._
import chisel3.experimental.MultiIOModule
import common.Adder
import state.GlobalStateDecoder

class FPGATopLevel() extends MultiIOModule {

  val io = IO(
    new Bundle {
      val spiPacketIn = Input(UInt(256.W))
      val resultOut = Output(SInt(32.W))
    }
  )

  val debug = IO(
    new Bundle {
      val packet_select = Output(UInt())
      val note_index = Output(UInt())
      val volume_out = Output(UInt())
      val envelope_out = Output(UInt())
      val pitchwheel_out = Output(UInt())
      val gen7_out = Output(SInt())
    }
  )


  val GlobalStateDecoder = Module(new GlobalStateDecoder())
  val GeneratorStateDecoder = Module(new GeneratorStateDecoder())
  val Adder = Module(new Adder())

  when(io.spiPacketIn(7, 0) === 1.U) {
    GlobalStateDecoder.io.packetIn := io.spiPacketIn(255, 8)
    GlobalStateDecoder.io.writeEnable := 1.U.toBool()
  } otherwise {
    GlobalStateDecoder.io.packetIn := 0.U
    GlobalStateDecoder.io.writeEnable := 0.U.toBool()
  }

  when (io.spiPacketIn(7, 0) === 2.U) {
    GeneratorStateDecoder.io.packetIn := io.spiPacketIn(95, 8)
  } otherwise {
    GeneratorStateDecoder.io.packetIn := 0.U
  }

  for (i <- 1 to 16) {
    val GeneratorNumber = Module(new Generator())
    GeneratorNumber.io.pitchWheelArrayIn := GlobalStateDecoder.io.PitchWheelOut
    GeneratorNumber.io.envelopeIn := GlobalStateDecoder.io.EnvelopeOut

    Adder.io.adderInputs(i-1) := GeneratorNumber.io.sampleOut
    GeneratorNumber.io.generatorPacketIn := GeneratorStateDecoder.io.GeneratorPacketOut

    when(GeneratorStateDecoder.io.indexOut === i.U) {
      GeneratorNumber.io.writeEnable := true.B
    } otherwise {
      GeneratorNumber.io.writeEnable := false.B
    }

    if(i == 7) {
      debug.gen7_out := GeneratorNumber.io.sampleOut
    }
  }

  io.resultOut := Adder.io.soundOutput
  debug.packet_select := io.spiPacketIn(7, 0)
  debug.note_index := GeneratorStateDecoder.io.indexOut
  debug.volume_out := GlobalStateDecoder.io.volumeOut
  debug.envelope_out := GlobalStateDecoder.io.EnvelopeOut.asUInt()
  debug.pitchwheel_out := GlobalStateDecoder.io.PitchWheelOut.asUInt()

}
