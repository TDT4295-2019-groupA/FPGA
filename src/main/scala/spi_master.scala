package sadie.generator

import chisel3._
import chisel3.experimental.MultiIOModule

class SPI_Master extends MultiIOModule {
  val io = IO(
    new Bundle {
      val transmit = Input(Bool())
      val load_sample = Input(Bool())
      val sample_in = Input(SInt(16.W))

      val spi_clock_out = Output(Bool())
      val spi_slave_select = Output(Bool())
      val spi_bit_out = Output(UInt(1.W))
    }
  )

  val sample_store = RegInit(UInt(16.W), 0.U)
  val clock_edge = RegInit(Bool(), false.B)

  when(io.load_sample) {
    sample_store := io.sample_in
    clock_edge := true.B
  }.elsewhen(io.transmit) {
    when(!clock_edge) {
      sample_store := sample_store << 1
    }
    clock_edge := ! clock_edge
  }


  io.spi_clock_out := clock_edge
  io.spi_slave_select := !io.transmit && sample_store =/= 0.U
  io.spi_bit_out := Mux(io.transmit, sample_store(15), 0.U)
}
