package communication

import chisel3._
import chisel3.util._
import chisel3.experimental.MultiIOModule
import blackboxes.{SPISlave,SPIBus}
import generator.GeneratorStateDecoder
import state.GlobalStateDecoder

// Use this to quickly wire the output from SPIInputHandler using the <> operator
class SPIPacket extends Bundle {
  val valid =  Input(Bool()) // pulsed for one clock cycle
  val length = Input(UInt(8.W)) // in bytes
  val data = Input(UInt(256.W))
}

class SPIInputHandler extends MultiIOModule {
  val io = IO(new Bundle{
    val packet = Flipped(new SPIPacket)
    val spi = new SPIBus
  })

  // enums
  val sReset                = 0.U // MAGIC identifier
  val sGlobalUpdate         = 1.U // MAGIC identifier
  val sGeneratorUpdate      = 2.U // MAGIC identifier
  val GlobalUpdateLength    = 25.U // Bytes
  val GeneratorUpdateLength = 12.U // Bytes

  // our state
  val data = Reg(Vec(16, UInt(8.W)))
  val write_pos = RegInit(UInt(4.W), 0.U)

  // default output
  io.packet.valid := false.B
  io.packet.length := write_pos * 8.U
  io.packet.data := data.asUInt

  // initalize our spi slave
  val spi = Module(new SPISlave).io
  spi.spi <> io.spi

  // transmit nothing
  spi.TX_data_valid := false.B
  spi.TX_data := 0.U

  // read input
  when (spi.RX_data_valid) {
    // store data
    data(write_pos) := spi.RX_data
    write_pos := write_pos + 1.U

    // check if done
    when(write_pos > 0.U) {
      switch(data(0.U)) {
        is(sReset) {
          write_pos := 0.U
        }
        is(sGlobalUpdate) {
          when(write_pos + 1.U === GlobalUpdateLength) {
            write_pos := 0.U
            io.packet.valid := true.B
          }
        }
        is(sGeneratorUpdate) {
          when(write_pos + 1.U === GeneratorUpdateLength) {
            write_pos := 0.U
            io.packet.valid := true.B
          }
        }
      }
    }
  }
}
