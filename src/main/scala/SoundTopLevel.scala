package toplevel

import chisel3._
import chisel3.experimental.MultiIOModule
import common.Adder
import generator.{Generator, GeneratorStateDecoder, GeneratorUpdatePacket}
import state.{GlobalStateDecoder, GlobalUpdatePacket}

class SoundTopLevel() extends MultiIOModule {

  val io = IO(
    new Bundle {
      val genPacketIn = Input(new GeneratorUpdatePacket)
      val gloPacketIn = Input(new GlobalUpdatePacket)
      val gloWriteEnable = Input(Bool())
      val resultOut = Output(SInt(32.W))
    }
  )

  val debug = IO(
    new Bundle {
      val note_index = Output(UInt())
      val volume_out = Output(UInt())
      val envelope_out = Output(UInt())
      val pitchwheel_out = Output(UInt())
      val gen7_out = Output(SInt())
    }
  )


  val globalStateDecoder = Module(new GlobalStateDecoder())
  val generatorStateDecoder = Module(new GeneratorStateDecoder())
  val adder = Module(new Adder())

  globalStateDecoder.io.packetIn := io.gloPacketIn
  globalStateDecoder.io.writeEnable := io.gloWriteEnable
  generatorStateDecoder.io.packetIn := io.genPacketIn

  adder.io.volumeIn := globalStateDecoder.io.volumeOut

  for (i <- 1 to 16) {
    val generatorNumber = Module(new Generator())
    generatorNumber.io.pitchWheelArrayIn := globalStateDecoder.io.pitchWheelOut
    generatorNumber.io.envelopeIn := globalStateDecoder.io.envelopeOut

    adder.io.adderInputs(i-1) := generatorNumber.io.sampleOut
    generatorNumber.io.generatorPacketIn := generatorStateDecoder.io.GeneratorPacketOut

    when(generatorStateDecoder.io.indexOut === i.U) {
      generatorNumber.io.writeEnable := true.B
    } otherwise {
      generatorNumber.io.writeEnable := false.B
    }

    if(i == 7) {
      debug.gen7_out := generatorNumber.io.sampleOut
    }
  }

  io.resultOut := adder.io.soundOutput
  debug.note_index := generatorStateDecoder.io.indexOut
  debug.volume_out := globalStateDecoder.io.volumeOut
  debug.envelope_out := globalStateDecoder.io.envelopeOut.asUInt()
  debug.pitchwheel_out := globalStateDecoder.io.pitchWheelOut.asUInt()

}
