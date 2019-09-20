package generator

import chisel3._
import chisel3.experimental.MultiIOModule

class VivadoTest() extends MultiIOModule {
  val io = IO(
    new Bundle {
      val led = Output(UInt(4.W))
      val sw = Input(UInt(4.W))
    }
  )


  when(io.sw(0)) {
      io.led := 0x0.U
  }.otherwise {
      io.led := 0x1.U
  }

}
