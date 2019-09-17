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

  val GlobalStateDecoder = Module(new GlobalStateDecoder())
  val GeneratorStateDecoder = Module(new GeneratorStateDecoder())

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




}
