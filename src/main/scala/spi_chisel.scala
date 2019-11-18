package sadie

import chisel3._
import chisel3.experimental.MultiIOModule

class SpiChisel extends MultiIOModule {
  val io = IO(
    new Bundle {
      val spi_clock = Input(Bool())
      val spi_databit_in = Input(UInt(1.W))
      val spi_slave_select = Input(Bool())

      val spi_package_out = Output(UInt())
      val spi_package_ready = Output(Bool())
      val bit_count_out = Output(UInt(16.W))
    }
  )

  val lastClock = RegInit(Bool(), false.B)
  val dataStore = RegInit(UInt(256.W), 0.U)
  val wasActive = RegInit(Bool(), false.B)
  val bitCount = RegInit(UInt(16.W), 0.U)

  io.spi_package_out := dataStore
  io.bit_count_out := bitCount

  when(!io.spi_slave_select) {
    when(!wasActive) {
      wasActive := true.B
      dataStore := io.spi_databit_in
      bitCount := 1.U
    }
    .elsewhen(lastClock =/= io.spi_clock && io.spi_clock) {
      dataStore := (dataStore << 1) | io.spi_databit_in
      bitCount := bitCount + 1.U
    }
    lastClock := io.spi_clock
    io.spi_package_ready := false.B
  }.otherwise {
    io.spi_package_ready := dataStore =/= 0.U
    wasActive := false.B
  }
}
