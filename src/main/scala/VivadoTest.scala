package generator

import chisel3._
import chisel3.experimental.MultiIOModule
import blackboxes._

class VivadoTestBundle extends Bundle {
  val btn      = Input(UInt(4.W))
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


  // button counter
  val btn_counter = RegInit(UInt(4.W), 5.U);
  when(io.btn(1)) {
    btn_counter := 1.U
  }.elsewhen(io.btn(2) && (! btn_prev(2)) && (! btn_prev_2(2)) && (! btn_prev_4(2)) && (! btn_prev_4(2))) {
    btn_counter := btn_counter + 1.U
  }

  // do rgb
  val pwm = Reg(UInt(3.W))
  pwm := pwm + 1.U
  when(io.sw(3)) {
    when(io.btn(3) && pwm === 0.U) {
      io.rgbled_0 := 0x4.U
      io.rgbled_1 := 0x2.U
      io.rgbled_2 := 0x7.U
      io.rgbled_3 := 0x1.U
    }
  } otherwise {
    when(io.btn(3) && pwm(0)) {
      io.rgbled_0 := 0x4.U
      io.rgbled_1 := 0x2.U
      io.rgbled_2 := 0x7.U
      io.rgbled_3 := 0x1.U
    }
  }

  // do spi
  val spi_reg = RegInit(UInt(4.W), 8.U)
  val rx = Module(new SPIReciever()).io
  rx.TX_data_valid := false.B
  rx.TX_data := 0.U
  rx.spi <> io.spi
  when(rx.RX_data_valid) {
    spi_reg := rx.RX_data
  }
  //spi_reg := (io.spi.mosi << 3) | (false.B << 2) | (io.spi.clk << 1) | (io.spi.cs_n << 0)
  //io.spi.miso := false.B

  // do LED
  when(io.sw(0)) {
    io.led := btn_counter
  }.elsewhen(io.sw(1)) {
    when(io.btn(0)) {
      io.led := (io.spi.mosi << 0.U) | (false.B << 1.U) | (io.spi.clk << 2.U) | (io.spi.cs_n << 3.U)
    } otherwise {
      io.led := spi_reg
    }
  }.otherwise {
    io.led := io.sw(1) | (io.sw(2)<<1.U) | (io.sw(3)<<2.U)
  }



  //when(io.btn(0) && (! btn_prev(0)) && (! btn_prev_2(0)) && (! btn_prev_4(0)) && (! btn_prev_4(0))) {
  //}

}
