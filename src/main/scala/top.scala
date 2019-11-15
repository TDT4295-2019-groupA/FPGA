package sadie.generator

import chisel3._
import chisel3.Flipped
import chisel3.core.withClock
import chisel3.experimental.MultiIOModule
import chisel3.util._
import sadie.blackboxes._
import sadie.common._
import sadie.communication._
import sadie.config.config
import sadie.i2s
import sadie.toplevel.SoundTopLevel

class TopBundle extends Bundle {
  val spi = new SPIBus()
  //val i2s = new I2SBus()
  val led_green = Output(UInt(1.W))
  val gpio = Output(UInt(1.W))
  val spidebug = Flipped(new SPIBus())
  val SPIClock = Output(Clock())

  val BitClock = Output(Clock())
  val LeftRightWordClock = Output(Bool())
  val DataBit = Output(UInt())
  val SystemClock = Output(Clock())
}

class Top() extends MultiIOModule {
  val io = IO(new TopBundle)
  io.led_green := 1.U
  val reggie = RegInit(Bool(), false.B)
  io.gpio := reggie
  io.DataBit := 0.U
  io.LeftRightWordClock := 0.U
  // initalize top-modules
  
  val clockConfigs:List[ClockConfig] = List(
    ClockConfig(600, 0.5, 0.0), // For SPI testing, it's a little over 1MHz so a non-CCIO pin should be able to handle it(?)
    ClockConfig.default, 
    ClockConfig.default, 
    ClockConfig.default,
    ClockConfig(4, 0.5, 0.0), //For BCK
    ClockConfig.default,
    ClockConfig(60, 0.5, 0.0), //For SCK
  )
  // clocking stuff goes here
  //42.336 = clock speed of 677.376 MHz, divide by 60 to get sck
  val mmcm = Module(new MMCME2(62.5, 42.336, 1, clockConfigs, true))
  mmcm.CLKIN1 := clock
  mmcm.CLKFBIN := mmcm.CLKFBOUT
  mmcm.PWRDWN := false.B
  mmcm.RST := false.B
  val SystemClock = mmcm.CLKOUT6
  val BitClock = mmcm.CLKOUT4
  val SPIClock = mmcm.CLKOUT0

  io.SystemClock := SystemClock
  io.BitClock := BitClock
  io.SPIClock := SPIClock

  // output audio as PWM
  // drive the SPISlave

  withClock(SPIClock) {
    val rx    = Module(new SPISlave()).io
    val input = Module(new SPIInputHandler).io
    input.RX_data       := rx.RX_data
    input.RX_data_valid := rx.RX_data_valid

    rx.TX_data_valid := false.B // transmit nothing
    rx.TX_data := 0.U
    rx.spi <> io.spi // connect spi slave bus to io
    when (rx.RX_data > 0.U) {
      reggie := true.B
    }

    io.spidebug.clk := rx.spi.clk
    io.spidebug.cs_n := rx.spi.cs_n
    io.spidebug.mosi := rx.spi.mosi
    // signal valid SPI packages
    when (input.packet.valid) {
      switch (input.packet.magic) {
        is (config.sReset.U) {
          // TODO?
          // I'd recommend not using this because a package covered in 0s would read as reset but is likely just corrupt
        }
//        is (config.sGlobalUpdate.U) {
//          sound.global_update_packet_valid    := true.B
//        }
//        is (config.sGeneratorUpdate.U) {
//          sound.generator_update_packet_valid := true.B
//        }
      }
    }
  }
//  withClock(BitClock) {
//    val sound = Module(new SoundTopLevel).io
//    val current_bit_index = RegInit(UInt(8.W), 0.U)
//    val left_right_channel_select = RegInit(Bool(), false.B)
//
//    current_bit_index := current_bit_index + 1.U
//
//    when(current_bit_index === 31.U) {
//      current_bit_index := 0.U
//      left_right_channel_select := !left_right_channel_select
//    }
//
//    // drive SoundTopLevel
//    sound.global_update_packet          := input.packet.data.asTypeOf(new GlobalUpdatePacket).withEndianSwapped()
//    sound.generator_update_packet       := input.packet.data.asTypeOf(new GeneratorUpdatePacket).withEndianSwapped()
//    sound.global_update_packet_valid    := false.B // overridden below
//    sound.generator_update_packet_valid := false.B // overridden below
//    sound.step_sample                   := false.B // overridden below
//    //io.i2c.data := sound.sample_out
//
//
//    // step audio generators at audio sample rate
//    val saved_sample = RegInit(SInt(32.W), 0.S)
//    sound.step_sample := true.B
//    saved_sample := sound.sample_out
//
//    //do this usually
//    //i2s.sound := sound.sample_out
//
//    //do this for a4
//    val a4SampleFlip = RegInit(SInt(32.W), 2147483647.S) //15727680.S)
//    val flip_time = RegInit(UInt(10.W), 0.U)
//
//    when(current_bit_index === 31.U) {
//      flip_time := flip_time + 1.U
//    }
//    when(flip_time === 80.U) {
//      flip_time := 0.U
//      a4SampleFlip := (-1.S) * a4SampleFlip
//    }
//
//    io.LeftRightWordClock := left_right_channel_select
//    io.DataBit := a4SampleFlip(current_bit_index)
//
//    // drive the input handler module
//
//  }

}
