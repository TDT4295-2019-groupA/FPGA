package sadie.generator

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util._
import chisel3.core.withClock
import sadie.blackboxes._
import sadie.common._
import sadie.communication._
import sadie.config.config
import sadie.toplevel.SoundTopLevel

class TopBundle extends Bundle {
  val spi = new SPIBus()
  //val i2s = new I2SBus()
  val spi_clock = Output(Bool())
  val spi_data_bit = Output(UInt(1.W))
  val spi_slave_select = Output(Bool())
}

class Top() extends MultiIOModule {
  val io = IO(new TopBundle)

  val clockConfigs:List[ClockConfig] = List(
    ClockConfig.default,
    ClockConfig.default, 
    ClockConfig.default, 
    ClockConfig.default,
    ClockConfig(3, 0.5, 0.0), //For BCK
    ClockConfig.default,
    ClockConfig(100, 0.5, 0.0), //For SCK
  )
  // clocking stuff goes here
  //42.336 = clock speed of 677.376 MHz, divide by 60 to get sck
  val mmcm = Module(new MMCME2(62.5, 37.5, 1, clockConfigs, true))
  mmcm.CLKIN1 := clock
  mmcm.CLKFBIN := mmcm.CLKFBOUT
  mmcm.PWRDWN := false.B
  mmcm.RST := false.B
  val SPIClock = mmcm.CLKOUT4 //2MHz

  val spi_master = withClock(SPIClock) { Module(new SPI_Master()) }


  withClock(SPIClock) {
    // initalize top-modules
    val rx    = Module(new SPISlave()).io
    val input = Module(new SPIInputHandler).io

    spi_master.io.load_sample := false.B
    spi_master.io.sample_in := 43201.S

    val (sample_rate_counter, _) = Counter(true.B, 1600000 / config.SAMPLE_RATE)

    val (dumb_ass_counter, _) = Counter(true.B, 60)

    io.spi_clock := spi_master.io.spi_clock_out
    io.spi_slave_select := spi_master.io.spi_slave_select
    io.spi_data_bit := spi_master.io.spi_bit_out

    when(dumb_ass_counter === 0.U) {
      spi_master.io.load_sample := true.B
    }

    // drive the SPISlave
    rx.TX_data_valid := false.B // transmit nothing
    rx.TX_data := 0.U
    rx.spi <> io.spi // connect spi slave bus to io
  
    // drive the input handler module
    input.RX_data       := rx.RX_data
    input.RX_data_valid := rx.RX_data_valid
  }
}
