package sadie.generator

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util._
import sadie.blackboxes._
import sadie.common._
import sadie.communication._
import sadie.config.config
import sadie.i2s
import sadie.toplevel.SoundTopLevel

class TopBundle extends Bundle {
  val spi = new SPIBus()
  //val i2s = new I2SBus()
  val led_green = Output(UInt(1.W))
  val gpio = Output(UInt(1.W))

  val BitClock = Output(Bool())
  val LeftRightWordClock = Output(UInt())
  val DataBit = Output(UInt())
  val SystemClock = Output(UInt())

}

class Top() extends MultiIOModule {
  val io = IO(new TopBundle)
  io.led_green := 1.U
  io.gpio := 1.U
  // initalize top-modules
  val sound = Module(new SoundTopLevel).io
  val rx    = Module(new SPISlave()).io
  val input = Module(new SPIInputHandler).io
  val i2s = Module(new i2s).io

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
  when (sample_rate_counter === 1.U) {
    saved_sample := sound.sample_out
  }

  // output autio as PWM
  // drive the SPISlave
  rx.TX_data_valid := false.B // transmit nothing
  rx.TX_data := 0.U
  rx.spi <> io.spi // connect spi slave bus to io

  //do this usually
  //i2s.sound := sound.sample_out

  //do this for a4
  val (_, flipTime) = Counter(true.B, config.FPGA_CLOCK_SPEED / 880)
  val a4SampleFlip = RegInit(SInt(32.W), 15727680.S)

  when(flipTime) {
    a4SampleFlip := (-1.S) * a4SampleFlip
  }

  i2s.SampleIn := a4SampleFlip

  io.SystemClock := i2s.SystemClock
  io.BitClock := i2s.BitClock
  io.LeftRightWordClock := i2s.LeftRightWordClock
  io.DataBit := i2s.DataBit

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
