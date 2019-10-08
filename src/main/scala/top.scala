package generator

import blackboxes._
import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util._
import common._
import communication._
import config.config
import state.GlobalUpdatePacket

class TopBundle extends Bundle {
  val spi = new SPIBus()
  //val i2s = new I2SBus()
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
  soundTopLevel.genWriteEnable := false.B
  soundTopLevel.gloWriteEnable := false.B
  //io.i2c.data := soundTopLevel.resultOut

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
        soundTopLevel.genWriteEnable := true.B
      }
    }
  }

}
