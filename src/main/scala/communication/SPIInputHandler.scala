package communication

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util._
import config.config

// TODO: this needs tests

// Use this to quickly wire the output from SPIInputHandler using the <> operator
class SPIPacket extends Bundle {
  val valid =  Input(Bool()) // pulsed for one clock cycle
  val length = Input(UInt(8.W)) // in bytes
  val data = Input(UInt(256.W))
}

// deserializes SPI packets using SPISlave
class SPIInputHandler extends MultiIOModule {
  val io = IO(new Bundle{
    val packet = Flipped(new SPIPacket)
    val RX_data       = Input(UInt(8.W))
    val RX_data_valid = Input(Bool())
  })

  // enums and protocol knowledge
  val GlobalUpdateLength    = 25.U // Bytes
  val GeneratorUpdateLength = 12.U // Bytes

  // our state
  val data = Reg(Vec(16, UInt(8.W)))
  val write_pos = RegInit(UInt(4.W), 0.U)

  // default output
  io.packet.valid := false.B
  io.packet.length := write_pos * 8.U
  io.packet.data := data.asUInt

  // read input
  when (io.RX_data_valid) {
    // store data
    data(write_pos) := io.RX_data
    write_pos := write_pos + 1.U

    // check if done
    when(write_pos > 0.U) {
      switch(data(0.U)) {
        is(config.sReset.U) {
          write_pos := 0.U
        }
        is(config.sGlobalUpdate.U) {
          when(write_pos + 1.U === GlobalUpdateLength) {
            write_pos := 0.U
            io.packet.valid := true.B
          }
        }
        is(config.sGeneratorUpdate.U) {
          when(write_pos + 1.U === GeneratorUpdateLength) {
            write_pos := 0.U
            io.packet.valid := true.B
          }
        }
      }
    }
  }
}
