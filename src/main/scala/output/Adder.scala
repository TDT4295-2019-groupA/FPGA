package output

import chisel3._
import chisel3.experimental.MultiIOModule

class Adder extends MultiIOModule{

  val io = IO(
    new Bundle {
      val adderInputs = Input(Vec(16, RegInit(UInt(16.W), 0.U)))
      val soundOutput = Output(UInt(16.W))
    }
  )
  io.soundOutput := sumVec(io.adderInputs)

  def sumVec(v : Vec[UInt]): Vec[UInt] = Vec(sumAll(v.toList))

  def sumLevel(ins: List[UInt]): List[UInt] = ins match {
    case a :: b :: t => a + b :: sumLevel(t)
    case a :: Nil => a + 0.U :: Nil
    case _ => Nil
  }

  def sumAll(ins: List[UInt]): UInt = if(ins.size == 1) ins(1) else {
    val level = sumLevel(ins)
    sumAll(level)
  }
}
