package blackboxes

import chisel3._
import chisel3.core.IntParam
import chisel3.util.HasBlackBoxResource
import chisel3.experimental.MultiIOModule
import chisel3.experimental.ExtModule

class SPIInterface extends Bundle{
  val mosi = Input(Bool())  // SPI Master out slave in
  val miso = Output(Bool()) // SPI Master in slave out
  val clk  = Input(Bool())  // SPI clock
  val cs_n = Input(Bool())  // SPI chip select
}

class SPIReciever extends MultiIOModule {
  val io = IO(new Bundle{
    val RX_data_valid = Output(Bool())    // Data Valid pulse (1 clock cycle)
    val RX_data       = Output(UInt(8.W)) // Byte received on MOSI
    val TX_data_valid = Input(Bool())     // Data Valid pulse to register i_TX_Byte
    val TX_data       = Input(UInt(8.W))  // Byte to serialize to MISO.
    // SPI Interface
    val spi           = new SPIInterface
  })

  val spi = Module(new SPIExternal())
  spi.i_Clk        := clock
  spi.i_Rst_L      := reset

  io.RX_data_valid := spi.o_RX_DV
  io.RX_data       := spi.o_RX_Byte

  spi.i_TX_DV      := io.TX_data_valid
  spi.i_TX_Byte    := io.TX_data

  spi.i_SPI_Clk    := io.spi.clk
  io.spi.miso      := spi.o_SPI_MISO
  spi.i_SPI_MOSI   := io.spi.mosi
  spi.i_SPI_CS_n   := io.spi.cs_n
}

// Blackbox, with shitty names
class SPIExternal extends ExtModule(Map("SPI_MODE" -> IntParam(0))) { // Verilog parameters
  override def desiredName: String = "SPI_Slave" // verilog name

  // Control/Data Signals
  val i_Clk     = IO(Input(Clock()))    // FPGA Clock, must be at least 4x faster than i_SPI_Clk
  val i_Rst_L   = IO(Input(Bool()))     // FPGA Reset
  val o_RX_DV   = IO(Output(Bool()))    // Data Valid pulse (1 clock cycle)
  val o_RX_Byte = IO(Output(UInt(8.W))) // Byte received on MOSI
  val i_TX_DV   = IO(Input(Bool()))     // Data Valid pulse to register i_TX_Byte
  val i_TX_Byte = IO(Input(UInt(8.W)))  // Byte to serialize to MISO.

  // SPI Interface
  val i_SPI_Clk  = IO(Input(Bool()))
  val o_SPI_MISO = IO(Output(Bool()))
  val i_SPI_MOSI = IO(Input(Bool()))
  val i_SPI_CS_n = IO(Input(Bool()))
}
