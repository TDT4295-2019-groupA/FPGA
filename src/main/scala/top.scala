package generator

import blackboxes._
import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util._
import common._
import communication._
import config.config
import state.GlobalUpdatePacket
import toplevel.SoundTopLevel

class TopBundle extends Bundle {
  val spi = new SPIBus()
  //val i2s = new I2SBus()
  val pwm_out = Output(Bool())
}

class Top() extends MultiIOModule {
  val io = IO(new TopBundle)

  // initalize top-modules
  val soundTopLevel = Module(new SoundTopLevel).io
  val rx = Module(new SPISlave()).io
  val input = Module(new SPIInputHandler).io

  // drive SoundTopLevel
  soundTopLevel.gloPacketIn    := input.packet.data.asTypeOf(new GlobalUpdatePacket)
  soundTopLevel.genPacketIn    := input.packet.data.asTypeOf(new GeneratorUpdatePacket)
  soundTopLevel.gloWriteEnable := false.B
  //io.i2c.data := soundTopLevel.resultOut

  val pwm = Module(new PWM(32)).io
  io.pwm_out := pwm.high
  pwm.target := (soundTopLevel.resultOut + 0x80000000.S ).asUInt

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
        // TODO
      }
      is (config.sGlobalUpdate.U) {
        soundTopLevel.gloWriteEnable := true.B
      }
      is (config.sGeneratorUpdate.U) {
      }
    }
  }

}
