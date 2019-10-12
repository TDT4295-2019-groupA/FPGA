package sadie.communication

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util._
import sadie.config.config

// TODO: this needs tests

// Use this to quickly wire the output from SPIInputHandler using the <> operator
class SPIPacket extends Bundle {
  val valid  = Input(Bool()) // pulsed for one clock cycle
  val length = Input(UInt(8.W)) // in bytes
  val magic  = Input(UInt(8.W))
  val data   = Input(UInt(256.W)) // 32 bytes
}

// deserializes SPI packets using SPISlave
class SPIInputHandler extends MultiIOModule {
  val io = IO(new Bundle{
    val packet        = Flipped(new SPIPacket)
    val RX_data       = Input(UInt(8.W))
    val RX_data_valid = Input(Bool())
  })

  // our state
  val data         = RegInit(UInt(256.W), 0.U) // 32 bytes
  val data_len     = RegInit(UInt(8.W), 0.U) // in bits
  val data_set     = Wire(UInt(256.W)) // wire setting the next value of data
  val data_len_set = Wire(UInt(8.W))   // wire setting the next value of data_len
  data_set     := data
  data_len_set := data_len
  data         := data_set
  data_len     := data_len_set

  val magic = Wire(UInt(8.W))
  magic := data_set >> (data_len_set - 8.U)

  // drive output
  io.packet.valid  := false.B
  io.packet.length := data_len_set >> 3.U
  io.packet.data   := data_set
  io.packet.magic  := magic

  // read input
  when (io.RX_data_valid) {
    // shift RX byte into data register
    data_set := (data << 8.U) | io.RX_data
    data_len_set := data_len + 8.U

    // check if done
    switch(magic) {
      is(config.sReset.U) {
        data     := 0.U
        data_len := 0.U
      }
      is(config.sGlobalUpdate.U) {
        when(data_len_set === (config.GlobalUpdateLength*8).U) {
          io.packet.valid := true.B
          data     := 0.U
          data_len := 0.U
        }
      }
      is(config.sGeneratorUpdate.U) {
        when(data_len_set === (config.GeneratorUpdateLength*8).U) {
          io.packet.valid := true.B
          data     := 0.U
          data_len := 0.U
        }
      }
    }
  }
}
