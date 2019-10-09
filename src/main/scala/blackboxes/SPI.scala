package blackboxes

import chisel3._
import chisel3.core.IntParam
import chisel3.experimental.MultiIOModule
import chisel3.experimental.ExtModule

class SPIBus extends Bundle{
  val mosi = Input(Bool())  // SPI Master out slave in
  val miso = Output(Bool()) // SPI Master in slave out
  val clk  = Input(Bool())  // SPI clock
  val cs_n = Input(Bool())  // SPI chip select
}

class SPISlave extends MultiIOModule {
  val io = IO(new Bundle{
    val RX_data_valid = Output(Bool())    // Data Valid pulse (1 clock cycle)
    val RX_data       = Output(UInt(8.W)) // Byte received on MOSI
    val TX_data_valid = Input(Bool())     // Data Valid pulse to register i_TX_Byte
    val TX_data       = Input(UInt(8.W))  // Byte to serialize to MISO.
    // SPI Interface
    val spi           = new SPIBus
  })

  val spi = Module(new SPI_Slave_nandland())
  spi.i_Clk        := clock
  spi.i_Rst_L      := !reset.asBool()

  io.RX_data_valid := spi.o_RX_DV
  io.RX_data       := spi.o_RX_Byte

  spi.i_TX_DV      := io.TX_data_valid
  spi.i_TX_Byte    := io.TX_data

  spi.i_SPI_Clk    := io.spi.clk
  io.spi.miso      := spi.o_SPI_MISO
  spi.i_SPI_MOSI   := io.spi.mosi
  spi.i_SPI_CS_n   := !io.spi.cs_n

/*
  val spi = Module(new SPI_Slave_opencores())
  spi.rstb         := !reset.asBool()
  io.RX_data_valid := spi.done
  io.RX_data       := spi.rdata
  //io.TX_data_valid
  spi.tdata        := io.TX_data

  io.spi.miso      := spi.sdout
  spi.sck          := io.spi.clk
  spi.sdin         := io.spi.mosi
  spi.ss           := io.spi.cs_n

  spi.mlb := true.B
  spi.ten := true.B
*/
}

// Blackbox for verilog module, along with its shitty names
class SPI_Slave_nandland extends ExtModule(Map("SPI_MODE" -> IntParam(0))) { // Verilog parameters
  override def desiredName: String = "SPI_Slave_nandland" // verilog name
  //setResource("/verilog/nandland/SPI_Slave_nandland.v") // doesn't work for ExtModule, only BlackBox :(

  // Control/Data Signals
  val i_Clk     = IO(Input(Clock()))    // FPGA Clock, must be at least 4x faster than i_SPI_Clk
  val i_Rst_L   = IO(Input(Bool()))     // FPGA Reset, Active low
  val o_RX_DV   = IO(Output(Bool()))    // Data Valid pulse (1 clock cycle)
  val o_RX_Byte = IO(Output(UInt(8.W))) // Byte received on MOSI
  val i_TX_DV   = IO(Input(Bool()))     // Data Valid pulse to register i_TX_Byte
  val i_TX_Byte = IO(Input(UInt(8.W)))  // Byte to serialize to MISO.

  // SPI Interface
  val i_SPI_Clk  = IO(Input(Bool()))
  val o_SPI_MISO = IO(Output(Bool()))
  val i_SPI_MOSI = IO(Input(Bool()))
  val i_SPI_CS_n = IO(Input(Bool()))    // Active low
}

// Blackbox for verilog module, along with its shitty names
class SPI_Slave_opencores extends ExtModule() { // Verilog parameters
  override def desiredName: String = "spi_slave" // verilog name

  val rstb  = IO(Input(Bool()))
  val ss    = IO(Input(Bool()))
  val sck   = IO(Input(Bool()))
  val sdin  = IO(Input(Bool()))
  val ten   = IO(Input(Bool()))
  val mlb   = IO(Input(Bool()))
  val tdata = IO(Input(UInt(8.W)))

  val sdout = IO(Output(Bool()))
  val done  = IO(Output(Bool()))
  val rdata = IO(Output(UInt(8.W)))
}
