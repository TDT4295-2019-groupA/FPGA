package sadie.generator

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util._
import chisel3.core.withClock
import sadie.SpiChisel
import sadie.blackboxes._
import sadie.common._
import sadie.communication._
import sadie.config.config
import sadie.toplevel.SoundTopLevel

class TopBundle extends Bundle {
  val spi = new SPIBus()
  val spi_clock = Output(Bool())
  val spi_data_bit = Output(UInt(1.W))
  val spi_slave_select = Output(Bool())
  val spi_debug = Output(Bool())
}

class Top() extends MultiIOModule {
  val io = IO(new TopBundle)

  val clockConfigs:List[ClockConfig] = List(
    ClockConfig.default,
    ClockConfig.default,
    ClockConfig.default,
    ClockConfig.default,
    ClockConfig(15, 0.5, 0.0), //1.6 MHz
    ClockConfig.default,
    ClockConfig(25, 0.5, 0.0), //24 MHz
  )
  // clocking stuff goes here
  //37.5 = 600 MHz. Minimum requirement
  //50 base div gives us a base of 12 MHz, 12 is a nice number for division
  val mmcm = Module(new MMCME2(62.5, 37.5, 1, clockConfigs, true))
  mmcm.CLKIN1 := clock
  mmcm.CLKFBIN := mmcm.CLKFBOUT
  mmcm.PWRDWN := false.B
  mmcm.RST := false.B
  val SystemClock = mmcm.CLKOUT4

  val spi_master = withClock(SystemClock) { Module(new SPI_Master()).io }
  val spi_chisel = withClock(SystemClock) {Module(new SpiChisel()).io}
  val sound = withClock(SystemClock) {Module(new SoundTopLevel()).io}
  val spi_ever_valid = RegInit(Bool(), false.B)

  spi_chisel.spi_clock := io.spi.clk
  spi_chisel.spi_databit_in := io.spi.mosi
  spi_chisel.spi_slave_select := io.spi.cs_n

  // drive SoundTopLevel
  sound.global_update_packet          := spi_chisel.spi_package_out.asTypeOf(new GlobalUpdatePacket).withEndianSwapped()
  sound.generator_update_packet       := spi_chisel.spi_package_out.asTypeOf(new GeneratorUpdatePacket).withEndianSwapped()
  sound.global_update_packet_valid    := spi_chisel.spi_package_type === 1.U && spi_chisel.spi_package_ready
  sound.generator_update_packet_valid := spi_chisel.spi_package_type === 2.U && spi_chisel.spi_package_ready


  when(spi_chisel.spi_package_ready && spi_chisel.spi_package_type =/= 0.U) {
    spi_ever_valid := true.B
  }

  io.spi_debug := spi_ever_valid

  spi_master.load_sample := false.B
  spi_master.sample_in := (sound.sample_out >> 16.U).asUInt()

  sound.step_sample := false.B

  withClock(SystemClock) {
    val step = RegInit(UInt(12.W), 0.U)
    step := step + 1.U
    when(step === 0.U) {
      spi_master.load_sample := true.B
    }.elsewhen(step === 36.U) {
      step := 0.U
      sound.step_sample := true.B
    }
  }

  io.spi_clock := spi_master.spi_clock_out
  io.spi_slave_select := spi_master.spi_slave_select
  io.spi_data_bit := spi_master.spi_bit_out

}
