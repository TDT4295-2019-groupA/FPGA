package generator

import chisel3._
import chisel3.experimental.MultiIOModule
import blackboxes._

class VivadoTestBundle extends Bundle {
  val btn      = Input(UInt(3.W))
  val sw       = Input(UInt(4.W))
  val led      = Output(UInt(4.W))
  val rgbled_0 = Output(UInt(3.W))
  val rgbled_1 = Output(UInt(3.W))
  val rgbled_2 = Output(UInt(3.W))
  val rgbled_3 = Output(UInt(3.W))

  val spi = new SPIInterface()
}

class VivadoTest() extends MultiIOModule {
  val io = IO(new VivadoTestBundle)

  val btn_prev = RegInit(UInt(4.W), 0.U);
  btn_prev := io.btn
  val btn_prev_2 = RegInit(UInt(4.W), 0.U);
  btn_prev_2 := btn_prev
  val btn_prev_3 = RegInit(UInt(4.W), 0.U);
  btn_prev_3 := btn_prev_2
  val btn_prev_4 = RegInit(UInt(4.W), 0.U);
  btn_prev_4 := btn_prev_3

  // make sure everything is driven
  io.led := 0.U
  io.rgbled_0 := 0.U
  io.rgbled_1 := 0.U
  io.rgbled_2 := 0.U
  io.rgbled_3 := 0.U


  // count c
  val c = RegInit(UInt(4.W), 5.U);
  when(io.btn(1)) {
    c := 1.U
  }.elsewhen(io.btn(2) && (! btn_prev(2)) && (! btn_prev_2(2)) && (! btn_prev_4(2)) && (! btn_prev_4(2))) {
    c := c + 1.U
  }

  // do rgb
  when(io.btn(0)) {
    io.rgbled_0 := 0x4.U
    io.rgbled_1 := 0x2.U
    io.rgbled_2 := 0x7.U
    io.rgbled_3 := 0x1.U
  }

  val spi_reg = RegInit(UInt(4.W), 8.U)
  val rx = Module(new SPIReciever()).io
  rx.TX_data_valid := false.B
  rx.TX_data := 0.U
  rx.spi <> io.spi
  when(rx.RX_data_valid) {
    spi_reg := rx.RX_data
  }

  // do LED
  when(io.sw(0)) {
    io.led := c
  }.elsewhen(io.sw(1)) {
    io.led := spi_reg
  }.otherwise {
    io.led := io.sw(1) | (io.sw(2)<<1.U) | (io.sw(3)<<2.U)
  }



  //when(io.btn(0) && (! btn_prev(0)) && (! btn_prev_2(0)) && (! btn_prev_4(0)) && (! btn_prev_4(0))) {
  //}

}
