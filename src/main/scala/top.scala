package sadie

import chisel3._
import chisel3.core.withClock
import blackboxes.{MMCME2, ClockConfig}
import chisel3.internal.firrtl.Width
import chisel3.util.MuxLookup
import chisel3.util.Counter

class TopBundle extends Bundle {
  val SystemClock    = Output(Clock())
  val BitClock    = Output(Bool())
  val BitClockDebug    = Output(Bool())
  val LeftRightWordClock = Output(Bool())
  val LeftRightWordClockDebug = Output(Bool())
  val DataBit     = Output(Bool())
  val DataBitDebug     = Output(Bool())
  val gpio = Output(Bool())
}

/**
  * A test for using multiple clocks at the same time
  */
class Top extends Module {
  val io = IO(new TopBundle)

  /*
   * SETUP CLOCKS
   */

  // Normally we use the base mult and divide to get the frequency
  // to the range we want, and then the individual divides (up to 128)
  // to get the exact frequency for each clock. In this case the difference
  // between the system clock and sample clock is too big for that (256 times),
  // so we must use a special feature of the MMCME2 module. We can cascade the
  // divide value of clock 6 into clock 4, so we can divide a lot further.
  val clockConfig = List(
    ClockConfig.default,
    ClockConfig.default,
    ClockConfig.default,
    ClockConfig.default,
    ClockConfig(2, 0.5, 0.0),  // comClock, divided from the system clock
    ClockConfig.default,
    ClockConfig(60, 0.5, 0.0) // System clock
  )
  // The period of a 16 MHz clock is 62.5 nanoseconds
  // We have to multiply be 37.888 to get over the required 600 MHz
  val mmcm = Module(new MMCME2(62.5, 42.336, 1, clockConfig, true))

  mmcm.CLKIN1   := clock
  mmcm.RST      := false.B //!reset.asBool()
  mmcm.PWRDWN   := false.B
  mmcm.CLKFBIN  := mmcm.CLKFBOUT

  val sysClock = mmcm.CLKOUT6
  val comClock = mmcm.CLKOUT4

  io.SystemClock := sysClock

   /*
    * Clock domain comClock = 2 x bitClock
    */

  val (c, _) = Counter(true.B, 16000000)
  io.gpio := 1.U
  when (c >= 8000000.U) {
    io.gpio := 0.U
  }

  val codec = withClock(comClock){Module(new Codec).io}

  withClock(comClock) {
    val notAnIndex = RegNext(0.U(16.W))
      notAnIndex := notAnIndex + 1.U

    val notASample = RegInit(SInt(32.W), 858993459.S)

    //io.DataBit := (notASample(notAnIndex / 2.U))

    when(notAnIndex >= 64.U) {
      notAnIndex := 0.U
    }

    val notACounter = RegNext(0.U(32.W))
    notACounter := notACounter + 1.U
    when(notACounter >= 3207.U) {
      notACounter := 0.U
      notASample := - notASample
    }
    codec.dac_in := notASample.asUInt()
    //io.DataBit := notASample(notAnIndex / 2.U)
    io.DataBit := codec.dac_out
    io.DataBitDebug := codec.dac_out

    // Clock outputs to codec
    io.LeftRightWordClock := codec.LRCLK
    io.LeftRightWordClockDebug := codec.LRCLK
    io.BitClock := codec.BCLK
    io.BitClockDebug := codec.BCLK

  }

  
}
