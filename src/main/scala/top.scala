package sadie.generator

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util._
import sadie.blackboxes._
import sadie.common._
import sadie.communication._
import sadie.config.config
import sadie.toplevel.SoundTopLevel



class TopBundle extends Bundle {
  val spi = new SPIBus()
  val i2s = new I2SBus()
  val led_green = Output(UInt(1.W))
  val gpio = Output(UInt(1.W))
}

class Top() extends MultiIOModule {
  val io = IO(new TopBundle)
  io.led_green := 1.U
  io.gpio := 1.U
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

  val i2s = Module(new I2S).io
  i2s.resetn := false.B
  // i don't know how this works
  i2s.wave_left_in := saved_sample.asUInt
  i2s.wave_right_in := saved_sample.asUInt
  i2s.i2s <> io.i2s

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
