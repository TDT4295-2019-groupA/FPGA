package FPGA

import chisel3._
import chisel3.experimental.MultiIOModule

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


  /**
    * Your code here
    */

  val volumeReg = RegInit(UInt(8.W), 0.U)
  val envelopeReg = Module(new Envelope)
  val pitchWheelReg = Module(new PitchWheelArray)

  val generatorStateDecoder = Module(new GeneratorStateDecoder())
  val globalStateDecoder = Module(new GlobalStateDecoder())

  when(io.spiPacketIn(7, 0) === 1.U) {
    generatorStateDecoder :=
  } otherwise {
    generatorStateDecoder.io
  }

  when (io.spiPacketIn(7, 0) === 2.U) {
    globalStateDecoder.io.packetIn := io.spiPacketIn(256, 8)
  } otherwise {
    globalStateDecoder.io.packetIn := 0.U
  }


}
