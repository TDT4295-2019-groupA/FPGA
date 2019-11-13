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
}

class Top() extends Module {
  val io = IO(new TopBundle)
  val second = 16000000.U
  def counter() = {
    val x = RegNext(0.asUInt(128.W))
    x := x + 1.U
    when (x === second) {
      x := 0.U
    }
    x
  } 
  val count = counter()
  io.gpio := true.B
  when (count >= second / 2.U) {
    io.gpio := false.B
  }
}
