package sadie.generator


import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util._
import sadie.blackboxes._
import sadie.common._
import sadie.communication._
import sadie.config.config
import sadie.i2s
import sadie.toplevel.SoundTopLevel

class TopBundle extends Bundle {
  val gpio = Output(Bool())
  val gpio2 = Output(Bool())
  val gpio3 = Output(Bool())
}

class Top() extends Module {
  val io = IO(new TopBundle)
  def counter() = {
    val x = RegNext(0.asUInt(128.W))
    x := x + 1.U
    x
  } 
  val count = RegNext(0.asUInt(128.W))
  val second = 16000000.U
  count := count + 1.U
  io.gpio := false.B
  io.gpio2 := false.B
  io.gpio3 := false.B
  when (count >= second * 2.U) {
    io.gpio := true.B
  }
  when(count <= second){
    io.gpio2 := true.B
  }
  when(count === 0.U) {
    io.gpio3 := true.B
  }
}
