package common

import chisel3._
import chisel3.experimental.MultiIOModule

class Adder extends MultiIOModule{

  val VELOCITY_MAX: SInt = 0x7f.S

  val io = IO(
    new Bundle {
      val adderInputs = Input(Vec(16, SInt(24.W)))
      val volumeIn = Input(UInt(16.W))
      val soundOutput = Output(SInt(16.W))
    }
  )
  io.soundOutput := (sumVec(io.adderInputs) / VELOCITY_MAX) * io.volumeIn

  def sumVec(v : Vec[SInt]): SInt = Vec(sumAll(v.toList))(0)

  def sumLevel(ins: List[SInt]): List[SInt] = ins match {
    case a :: b :: t => a + b :: sumLevel(t)
    case a :: Nil => a + 0.S :: Nil
    case _ => Nil
  }

  def sumAll(ins: List[SInt]): SInt = if(ins.size == 1) ins(0) else {
    val level = sumLevel(ins)
    sumAll(level)
  }
}
