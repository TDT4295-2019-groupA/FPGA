package sadie.generator

import chisel3._
import chisel3.experimental.MultiIOModule

class SPI_Master extends MultiIOModule {
  val io = IO(
    new Bundle {
      val load_sample = Input(Bool())
      val sample_in = Input(UInt(16.W))

      val spi_clock_out = Output(Bool())
      val spi_slave_select = Output(Bool())
      val spi_bit_out = Output(UInt(1.W))
    }
  )

  val sample_store = RegInit(UInt(16.W), 0.U)
  val clock_edge = RegInit(Bool(), false.B)
  val bit_count = RegInit(UInt(32.W), 0.U)
  clock_edge := !clock_edge

  when(io.load_sample) {
    sample_store := io.sample_in
    clock_edge := false.B
    bit_count := 0.U
  }.otherwise{
    when(clock_edge) {
      sample_store := sample_store << 1
      bit_count := bit_count + 1.U
    }
  }

  io.spi_clock_out := clock_edge
  io.spi_slave_select := bit_count >= 16.U
  io.spi_bit_out := sample_store(15)
}
