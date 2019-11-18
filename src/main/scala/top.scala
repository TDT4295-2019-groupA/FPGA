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
    ClockConfig(15, 0.5, 0.0), //For BCK
    ClockConfig.default,
    ClockConfig(25, 0.5, 0.0), //For SCK
  )
  // clocking stuff goes here
  //42.336 = clock speed of 677.376 MHz, divide by 60 to get sck
  val mmcm = Module(new MMCME2(62.5, 37.5, 1, clockConfigs, true))
  mmcm.CLKIN1 := clock
  mmcm.CLKFBIN := mmcm.CLKFBOUT
  mmcm.PWRDWN := false.B
  mmcm.RST := false.B
  val SPIClock = mmcm.CLKOUT6 //1.6MHz

  val spi_master = withClock(SPIClock) { Module(new SPI_Master()) }


  withClock(SPIClock) {
    // initalize top-modules
    val sound = Module(new SoundTopLevel).io
    val rx    = Module(new SPISlave()).io
    val input = Module(new SPIInputHandler).io
  
    // drive SoundTopLevel
    sound.global_update_packet          := input.packet.data.asTypeOf(new GlobalUpdatePacket).withEndianSwapped()
    sound.generator_update_packet       := input.packet.data.asTypeOf(new GeneratorUpdatePacket).withEndianSwapped()
    sound.global_update_packet_valid    := false.B // overridden below
    sound.generator_update_packet_valid := false.B // overridden below
    sound.step_sample                   := false.B // overridden below


    spi_master.io.transmit := true.B
    spi_master.io.load_sample := false.B

    val saved_sample = RegInit(SInt(32.W), 0.S)
    val (sample_rate_counter, _) = Counter(true.B, 1600000 / config.SAMPLE_RATE)
    when (sample_rate_counter === 0.U) {
      sound.step_sample := true.B
      saved_sample := sound.sample_out
    }
    when (sound.sample_out_valid) {
      saved_sample := sound.sample_out
      spi_master.io.sample_in := ((sound.sample_out * 65536.S) / 2147483647.S)
      spi_master.io.load_sample := true.B
    }


    io.spi_clock := spi_master.io.spi_clock_out
    io.spi_slave_select := spi_master.io.spi_slave_select
    io.spi_data_bit := spi_master.io.spi_bit_out

    // drive the SPISlave
    rx.TX_data_valid := false.B // transmit nothing
    rx.TX_data := 0.U
    rx.spi <> io.spi // connect spi slave bus to io
  
    // drive the input handler module
    input.RX_data       := rx.RX_data
    input.RX_data_valid := rx.RX_data_valid
  
    // signal valid SPI packages
    when (input.packet.valid) {
      switch (input.packet.magic) {
        is (config.sReset.U) {
          // TODO?
        }
        is (config.sGlobalUpdate.U) {
          sound.global_update_packet_valid    := true.B
        }
        is (config.sGeneratorUpdate.U) {
          sound.generator_update_packet_valid := true.B
        }
      }
    }
  }
}
