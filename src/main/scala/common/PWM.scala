package common

import chisel3._
import chisel3.experimental.MultiIOModule

class PWM(val width:Int = 8, val step:BigInt = 1) extends MultiIOModule {
  val io = IO(new Bundle{
    val high   = Output(Bool())    // Data Valid pulse (1 clock cycle)
    val target = Input(UInt(width.W))
  })

	val counter = RegInit(UInt(width.W), 0.U)
	counter := counter + step.U
	when (counter > io.target) {
		io.high := false.B
	} otherwise {
		io.high := true.B
	}
}
