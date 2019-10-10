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
  val pwm_out = Output(Bool()) // temporary audio output
}

class Top() extends MultiIOModule {
  val io = IO(new TopBundle)

  // initalize top-modules
  val sound_top_level = Module(new SoundTopLevel).io
  val rx = Module(new SPISlave()).io
  val input = Module(new SPIInputHandler).io

  // drive SoundTopLevel
  sound_top_level.generator_update_packet_valid := false.B // overridden below
  sound_top_level.generator_update_packet       := input.packet.data.asTypeOf(new GeneratorUpdatePacket).withEndianSwapped()
  sound_top_level.global_update_packet_valid    := false.B // overridden below
  sound_top_level.global_update_packet          := input.packet.data.asTypeOf(new GlobalUpdatePacket).withEndianSwapped()
  sound_top_level.step_sample                   := false.B // overridden below
  //io.i2c.data := sound_top_level.sample_out

  val pwm = Module(new PWM(32)).io
  io.pwm_out := pwm.high
  pwm.target := (sound_top_level.sample_out + 0x80000000.S ).asUInt

  // drive the SPISlave
  rx.TX_data_valid := false.B // transmit nothing
  rx.TX_data := 0.U
  rx.spi <> io.spi // connect spi slave bus to io

  // drive the input handler module
  input.RX_data       := rx.RX_data
  input.RX_data_valid := rx.RX_data_valid

  when (input.packet.valid) {
    switch (input.packet.data(7,0)) {
      is (config.sReset.U) {
        // TODO?
      }
      is (config.sGlobalUpdate.U) {
        sound_top_level.global_update_packet_valid    := true.B
      }
      is (config.sGeneratorUpdate.U) {
        sound_top_level.generator_update_packet_valid := true.B
      }
    }
  }

}
