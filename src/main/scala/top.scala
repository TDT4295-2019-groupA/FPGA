package sadie.generator

import chisel3._
import chisel3.util.Counter

class TopBundle extends Bundle {
  val gpio = Output(UInt(1.W))
  val gpio2 = Output(UInt(1.W))
  val gpio3 = Output(UInt(1.W))
}

class Top() extends Module {
  def counter() = {
    val x = RegNext(0.asUInt(128.W))
    x := x + 1.U
    x
  } 
  val init_counter = Counter(100000000)
  val next_counter = counter()
  init_counter.inc()
  val io = IO(new TopBundle)
  val reggie = RegInit(Bool(), true.B)
  val reggie2 = RegInit(Bool(), false.B)
  io.gpio := next_counter >= 16000000.U 
  io.gpio2 := next_counter === 0.U
  io.gpio3 := init_counter.value >= 10000000.U
}
