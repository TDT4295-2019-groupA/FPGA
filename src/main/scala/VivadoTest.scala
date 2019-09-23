package generator

import chisel3._
import chisel3.experimental.MultiIOModule

class VivadoTestBundle extends Bundle {
  val btn      = Input(UInt(4.W))
  val sw       = Input(UInt(4.W))
  val led      = Output(UInt(4.W))
  val rgbled_0 = Output(UInt(3.W))
  val rgbled_1 = Output(UInt(3.W))
  val rgbled_2 = Output(UInt(3.W))
  val rgbled_3 = Output(UInt(3.W))
}

class VivadoTest() extends MultiIOModule {
  val io = IO(new VivadoTestBundle)

  val btn_prev = RegInit(UInt(4.W), 0.U);
  btn_prev := io.btn

  // make sure everything is driven
  io.led := 0.U
  io.rgbled_0 := 0.U
  io.rgbled_1 := 0.U
  io.rgbled_2 := 0.U
  io.rgbled_3 := 0.U


  // count c
  val c = RegInit(UInt(4.W), 5.U);
  when(io.btn(2)) {
    c := 1.U
  }.elsewhen(io.btn(3) && (! btn_prev(3))) {
    c := c + 1.U
  }

  // do rgb
  when(io.btn(0)) {
    io.rgbled_0 := 0x4.U
    io.rgbled_3 := 0x1.U
  }
  when(io.btn(1)) {
    io.rgbled_1 := 0x2.U
    io.rgbled_2 := 0x7.U
  }

  // do LED
  when(io.sw(0)) {
    io.led := c
  }.otherwise {
    io.led := io.sw(1) | (io.sw(2)<<1.U) | (io.sw(3)<<2.U)
  }

}
