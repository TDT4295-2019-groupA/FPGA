package sadie

import chisel3._

class DACInterface extends Module {
  val io = IO(
    new Bundle {
      val BCLK = Input(Bool())
      val enable = Input(Bool())
      val sample = Input(UInt(32.W))

      val bit = Output(UInt(1.W))
      val ready = Output(Bool())
    }
  )

  val sample_reg = RegNext(0.U(32.W))
  val prev_bit = RegNext(io.bit)
  io.bit := prev_bit

  sample_reg := sample_reg
  io.ready := false.B

  when(!io.BCLK) {
    io.bit := sample_reg(31)

    // Need to use temp variable, because accumulator of type RegNext can't infer width when shifting
    // This should be changed to make the accumulator have explicit width
    val temp = Wire(UInt(32.W))
    temp := sample_reg << 1

    sample_reg := temp
    
    when(io.enable) {
      io.ready := true.B
      io.bit := io.sample(31)
      sample_reg := io.sample << 1
    }
  }
}