package sadie

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util.Counter
import sadie.config.config

class i2s() extends MultiIOModule {

  val io = IO(
    new Bundle {
      val sound = Input(SInt(32.W))

      val hard_reset = Input(Bool())

      //always 0 cause we drive this by PLL
      val sck = Output(Bool())
      //send one bit at a time
      val bitOut = Output(UInt(1.W))
      //0 = left, 1 = right, changes 1 before bits
      val channelOut = Output(UInt(1.W))
      //32 bit width, 2 channels, 1 tick per bit, both high and low = 2 * 64 * 44100
      val bitClockOut = Output(Bool())
    }
  )

  val (_, increment) = Counter(true.B, config.config.FPGA_CLOCK_SPEED / (2 * 64 * 44100))
  val (bitClockOut, _) = Counter(increment, 2)
  val (bitCount, bitReset) = Counter(increment, 64)
  val (channelSelect, _) = Counter(bitReset, 2)

  io.bitClockOut := bitClockOut === 1.U
  io.channelOut := channelSelect
  io.bitOut := io.sound(31.U - (bitCount / 2.U))
  io.sck := false.B



}
