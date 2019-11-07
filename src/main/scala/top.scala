package sadie.generator

import chisel3._
import chisel3.util.Counter

class TopBundle extends Bundle {
  val gpio = Output(UInt(1.W))
  val gpio2 = Output(UInt(1.W))
  val gpio3 = Output(UInt(1.W))
}

class Top() extends Module {
  val counter = Counter(100000000)
  counter.inc()
  val io = IO(new TopBundle)
  val reggie = RegInit(Bool(), true.B)
  val reggie2 = RegInit(Bool(), false.B)
  io.gpio := reggie
  io.gpio2 := reggie2
  io.gpio3 := counter.value === 0.U
}
