package sadie.generator

import chisel3._

class TopBundle extends Bundle {
  val gpio = Output(UInt(1.W))
  val gpio2 = Output(UInt(1.W))
}

class Top() extends Module {
  val io = IO(new TopBundle)
  val reggie = RegNext(Bool(), true.B)
  io.gpio := reggie
  io.gpio2 := 1.U
}
