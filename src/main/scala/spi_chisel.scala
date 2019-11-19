package sadie

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util.{MuxCase, MuxLookup}

class SpiChisel extends MultiIOModule {
  val io = IO(
    new Bundle {
      val spi_clock = Input(Bool())
      val spi_databit_in = Input(UInt(1.W))
      val spi_slave_select = Input(Bool())

      val spi_package_out = Output(UInt())
      val spi_package_ready = Output(Bool())
      val spi_package_type = Output(UInt(2.W))
    }
  )

  val lastClock = RegInit(Bool(), false.B)
  val dataStore = RegInit(UInt(256.W), 0.U)
  val wasActive = RegInit(Bool(), false.B)

  val packet_map = Array(
    (dataStore(207, 200) === 1.U) -> 1.U,
    (dataStore(71, 62) === 2.U) -> 2.U
  )

  io.spi_package_out := dataStore
  io.spi_package_type := MuxCase(0.U, packet_map)

  when(!io.spi_slave_select) {
    when(!wasActive) {
      wasActive := true.B
      dataStore := io.spi_databit_in
    }
    .elsewhen(lastClock =/= io.spi_clock && io.spi_clock) {
      dataStore := (dataStore << 1) | io.spi_databit_in
    }
    lastClock := io.spi_clock
    io.spi_package_ready := false.B
  }.otherwise {
    io.spi_package_ready := dataStore =/= 0.U
    wasActive := false.B
  }
}
