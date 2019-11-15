package sadie

import chisel3._

class DACInterface extends Module {
  val io = IO(
    new Bundle {
      val BCLK = Input(Bool())
      val enable = Input(Bool())
      val sample = Input(UInt(32.W))

      val bit = Output(UInt(1.W))
    }
  )

  val sample_reg = RegInit(UInt(32.W), 0.U)

  io.bit := sample_reg(31)

  when(io.enable && !io.BCLK) {
    sample_reg := io.sample
  }.elsewhen(!io.BCLK) {
    sample_reg := sample_reg(30, 0) << 1
  }
}