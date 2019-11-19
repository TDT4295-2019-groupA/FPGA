package sadie.generator

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.experimental.withClock
import chisel3.util._
import sadie.blackboxes._
import sadie.common._
import sadie.communication._
import sadie.config.config
import sadie.toplevel.SoundTopLevel

class TopBundle extends Bundle {
  val spi       = new SPIBus()
  val spi2      = new SPIBus()
  //val i2s     = new I2SBus()
  val pwm_out_l = Output(Bool()) // temporary audio output
  val pwm_out_r = Output(Bool()) // temporary audio output

  // arty 7 testing
  val sw        = Input(UInt(4.W))
}

class Top() extends MultiIOModule {
  val io = IO(new TopBundle)

  val clockConfigs:List[ClockConfig] = List(
    ClockConfig.default,
    ClockConfig.default,
    ClockConfig.default,
    ClockConfig.default,
    ClockConfig(10, 0.5, 0.0), //For rest
    ClockConfig.default,
    ClockConfig(1, 0.5, 0.0), //For pwm
  )
  val mmcm = Module(new MMCME2(10.0, 6, 1, clockConfigs, true))
  mmcm.CLKIN1 := clock
  mmcm.CLKFBIN := mmcm.CLKFBOUT
  mmcm.PWRDWN := false.B
  mmcm.RST := false.B
  val clock_rest = mmcm.CLKOUT4
  val clock_pwm = mmcm.CLKOUT6

  withClock(clock_rest) {

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
    //io.i2c.data := sound.sample_out

    // step audio generators at audio sample rate
    val saved_sample = RegInit(SInt(32.W), 0.S)
    val (sample_rate_counter, _) = Counter(true.B, config.FPGA_CLOCK_SPEED / config.SAMPLE_RATE)
    when (sample_rate_counter === 0.U) {
      sound.step_sample := true.B
      //saved_sample := sound.sample_out
    }
    when (sound.sample_out_valid) {
      saved_sample := sound.sample_out
    }

    // output audio as PWM
    withClock(clock_pwm) {
      //val pwm = Module(new PWM(32, 0x06060606)).io
      val pwm = Module(new PWM(32, 0x03030303)).io
      io.pwm_out_l := false.B
      io.pwm_out_r := false.B
      when (io.sw(0)) { io.pwm_out_l := pwm.high }
      when (io.sw(1)) { io.pwm_out_r := pwm.high }
      pwm.target := (saved_sample + 0x80000000.S(33.W) ).asUInt
    }

    // drive the SPISlave
    rx.TX_data_valid := false.B // transmit nothing
    rx.TX_data := 0.U
    // connect spi slave bus to io
    rx.spi <> io.spi
    when (io.sw(2)) {
      rx.spi.mosi := io.spi2.mosi
      rx.spi.clk  := io.spi2.clk
      rx.spi.cs_n := io.spi2.cs_n
    }
    io.spi2.miso := false.B

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
