package generator

import chisel3._
import chisel3.experimental.MultiIOModule
import generator.GeneratorStateDecoder
import output.Adder
import state.GlobalStateDecoder

class FPGATopLevel() extends MultiIOModule {

  val io = IO(
    new Bundle {
      val spiPacketIn = Input(UInt(256.W))
    }
  )

  val debug = IO(
    new Bundle {
      val myDebugSignal = Output(Bool())
    }
  )

  val GlobalStateDecoder = Module(new GlobalStateDecoder())
  val GeneratorStateDecoder = Module(new GeneratorStateDecoder())
  val Adder = Module(new Adder())

  when(io.spiPacketIn(7, 0) === 1.U) {
    GlobalStateDecoder.io.packetIn := io.spiPacketIn(255, 8)
  } otherwise {
    GlobalStateDecoder.io := 0.U
  }

  when (io.spiPacketIn(7, 0) === 2.U) {
    GeneratorStateDecoder.io.packetIn := io.spiPacketIn(95, 8)
  } otherwise {
    GeneratorStateDecoder.io.packetIn := 0.U
  }




  for (i <- 0 to 16) {
    val GeneratorNumber = new Generator()
    GeneratorNumber.io.pitchWheelArrayIn := GlobalStateDecoder.io.PitchWheelOut
    GeneratorNumber.io.envelopeIn := GlobalStateDecoder.io.EnvelopeOut

    Adder.io.adderInputs(i) := GeneratorNumber.io.sampleOut

    when(GeneratorStateDecoder.io.indexOut === i.U) {
      GeneratorNumber.io.generatorPacketIn := GeneratorStateDecoder.io.GeneratorPacketOut
    } otherwise {
      GeneratorNumber.io.generatorPacketIn := 0.U
    }
  }
}
