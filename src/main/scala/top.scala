package generator

import blackboxes._
import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util._
import common._
import communication._
import config.config
import toplevel.SoundTopLevel

class TopBundle extends Bundle {
  val spi = new SPIBus()
  //val i2s = new I2SBus()
  val pwm_out_l = Output(Bool()) // temporary audio output
  val pwm_out_r = Output(Bool()) // temporary audio output

  // arty 7 testing
  val sw       = Input(UInt(4.W))
  val btn      = Input(UInt(4.W))
  val led      = Output(UInt(4.W))
  val rgbled_0 = Output(UInt(3.W))
  val rgbled_1 = Output(UInt(3.W))
  val rgbled_2 = Output(UInt(3.W))
  val rgbled_3 = Output(UInt(3.W))
}

class Top() extends MultiIOModule {
  val io = IO(new TopBundle)
  io.led := 0.U
  io.rgbled_0 := 0.U
  io.rgbled_1 := 0.U
  io.rgbled_2 := 0.U
  io.rgbled_3 := 0.U

  // initalize top-modules
  val sound = Module(new SoundTopLevel).io
  val rx    = Module(new SPISlave()).io
  val input = Module(new SPIInputHandler).io

  // drive SoundTopLevel
  sound.global_update_packet          := input.packet.data.asTypeOf(new GlobalUpdatePacket).withEndianSwapped()
  sound.generator_update_packet       := input.packet.data.asTypeOf(new GeneratorUpdatePacket).withEndianSwapped()
  sound.global_update_packet_valid    := false.B // overridden below
  sound.generator_update_packet_valid := false.B // overridden below
  sound.step_sample                   := false.B // overridden below
  //io.i2c.data := sound.sample_out

  // step audio generators at audio sample rate
  val saved_sample = RegInit(SInt(32.W), 0.S)
  val (sample_rate_counter, _) = Counter(true.B, config.FPGA_CLOCK_SPEED / config.SAMPLE_RATE)
  when (sample_rate_counter === 0.U) {
    sound.step_sample := true.B
    //saved_sample := sound.sample_out
  }
  when (sample_rate_counter === 1.U) {
    saved_sample := sound.sample_out
  }

  // output autio as PWM
  val pwm = Module(new PWM(32, 0x30303030)).io
  io.pwm_out_l := false.B
  io.pwm_out_r := false.B
  when (io.sw(0)) { io.pwm_out_l := pwm.high }
  when (io.sw(1)) { io.pwm_out_r := pwm.high }
  pwm.target := (saved_sample + 0x80000000.S(33.W) ).asUInt
  when (io.sw(2)) {
    pwm.target := ((saved_sample << 13.U) + 0x80000000.S(33.W) ).asUInt
  }
  when (io.sw(3)) {
    pwm.target := ((saved_sample << 14.U) + 0x80000000.S(33.W) ).asUInt
  }

  // drive the SPISlave
  rx.TX_data_valid := false.B // transmit nothing
  rx.TX_data := 0.U
  rx.spi <> io.spi // connect spi slave bus to io

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

}
