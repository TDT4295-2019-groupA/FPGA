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

      val spi_test_out = Output(UInt(1.W))
      val spi_test_clock_out = Output(Bool())
    }
  )

  val lastClock = RegInit(Bool(), false.B)
  val dataStore = RegInit(UInt(256.W), 0.U)
  val wasActive = RegInit(Bool(), false.B)

  val testOut = RegInit(UInt(72.W), 0.U)

  io.spi_package_out := dataStore

  when(!io.spi_slave_select) {
    when(!wasActive) {
      wasActive := true.B
      dataStore := io.spi_databit_in
    }
    .elsewhen(lastClock =/= io.spi_clock && io.spi_clock) {
      dataStore := (dataStore << 1) ^ io.spi_databit_in
      testOut := testOut << 1
    }
    lastClock := io.spi_clock
    io.spi_package_ready := false.B
  }.otherwise {
    testOut := dataStore
    io.spi_package_ready := dataStore =/= 0.U
    wasActive := false.B
  }

  io.spi_test_out := testOut(71)
  io.spi_test_clock_out := io.spi_clock

}
