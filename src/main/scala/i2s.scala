package sadie

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util.Counter

class i2s() extends MultiIOModule {

  val io = IO(
    new Bundle {
      val SampleIn = Input(SInt(32.W))

      //always 0 cause we drive this by PLL
      val SystemClock = Output(Bool())
      //send one bit at a time
      val DataBit = Output(UInt(1.W))
      //0 = left, 1 = right, changes 1 before bits
      val LeftRightWordClock = Output(UInt(1.W))
      //32 bit width, 2 channels, 1 tick per bit, both high and low = 2 * 64 * 44100
      val BitClock = Output(Bool())
    }
  )

  val (_, systemClockPulse) = Counter(true.B, 2)
  val (_, increment) = Counter(true.B, config.config.FPGA_CLOCK_SPEED / (2 * 64 * 44100))
  val (bitClockOut, _) = Counter(increment, 2)
  val (bitCount, bitReset) = Counter(increment, 64)
  val (channelSelect, _) = Counter(bitReset, 2)

  io.BitClock := bitClockOut === 1.U
  io.LeftRightWordClock := channelSelect
  io.DataBit := Mux(bitCount < 2.U, io.SampleIn(0), io.SampleIn(31.U - ((bitCount - 2.U) / 2.U)))
  io.SystemClock := systemClockPulse



}
