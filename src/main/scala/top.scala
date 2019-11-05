package sadie.generator

import chisel3._
import chisel3.core.withClock
import chisel3.experimental.MultiIOModule
import chisel3.util._
import sadie.blackboxes._
import sadie.common._
import sadie.communication._
import sadie.config.config
//import sadie.i2s
import sadie.toplevel.SoundTopLevel

class TopBundle extends Bundle {
  val spi = new SPIBus()
  val i2s = new I2SBus()
  val led_green = Output(UInt(1.W))
  val gpio = Output(UInt(1.W))

//  val BitClock = Output(Clock())
//  val LeftRightWordClock = Output(Bool())
//  val DataBit = Output(UInt())
//  val SystemClock = Output(Clock())
}

class Top() extends MultiIOModule {
  val io = IO(new TopBundle)
  io.led_green := 1.U
  io.gpio := 1.U
  // initalize top-modules
  val rx    = Module(new SPISlave()).io
  val input = Module(new SPIInputHandler).io
  val i2s   = Module(new I2S(32.W))
  
  val clockConfigs:List[ClockConfig] = List(
    ClockConfig.default,
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


  // output audio as PWM
  // drive the SPISlave
  rx.TX_data_valid := false.B // transmit nothing
  rx.TX_data := 0.U
  rx.spi <> io.spi // connect spi slave bus to io

  //withClock(BitClock) {
  val sound = Module(new SoundTopLevel).io

  // drive SoundTopLevel
  sound.global_update_packet          := input.packet.data.asTypeOf(new GlobalUpdatePacket).withEndianSwapped()
  sound.generator_update_packet       := input.packet.data.asTypeOf(new GeneratorUpdatePacket).withEndianSwapped()
  sound.global_update_packet_valid    := false.B // overridden below
  sound.generator_update_packet_valid := false.B // overridden below
  sound.step_sample                   := false.B // overridden below
  //io.i2c.data := sound.sample_out


  // step audio generators at audio sample rate
  val saved_sample = RegInit(SInt(32.W), 0.S)
  sound.step_sample := true.B
  saved_sample := sound.sample_out

  //do this usually
  //i2s.sound := sound.sample_out

  //do this for a4
  val a4SampleFlip = RegInit(SInt(32.W), 15727680.S)
  val flip_time = RegInit(UInt(10.W), 0.U)

  when(flip_time === 80.U) {
    flip_time := 0.U
    a4SampleFlip := (-1.S) * a4SampleFlip // == ~a4SampleFlip + 1
  }

  i2s.io.MCLK_in := SystemClock
  i2s.io.resetn := false.B
  io.i2s <> i2s.io.i2s
  i2s.io.wave_left_in := a4SampleFlip.asUInt()
  i2s.io.wave_right_in := a4SampleFlip.asUInt()
  when (i2s.io.i2s.lrck) {
    flip_time := flip_time + 1.U
  }

  // drive the input handler module
  input.RX_data       := rx.RX_data
  input.RX_data_valid := rx.RX_data_valid

  // signal valid SPI packages
  when (input.packet.valid) {
    switch (input.packet.magic) {
      is (config.sReset.U) {
        // TODO?
      }
      is (config.sGlobalUpdate.U) {
        sound.global_update_packet_valid    := true.B
      }
      is (config.sGeneratorUpdate.U) {
        sound.generator_update_packet_valid := true.B
      }
    }
  }

  //}

}
