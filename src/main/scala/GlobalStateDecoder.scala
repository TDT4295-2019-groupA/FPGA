package FPGA

import chisel3._
import chisel3.experimental.MultiIOModule

class GlobalStateDecoder extends MultiIOModule {

  val io = IO(
    new Bundle {
      val packetIn = Input(UInt())

      val resetNoteOut = Output(Bool())
      val controlOut = Output(UInt())
      val generatorOut = Output(UInt())
    }
  )

  io.resetNoteOut := io.packetIn(0)
  io.controlOut := io.packetIn(2, 1)
  io.generatorOut := io.packetIn(10, 3)


}
