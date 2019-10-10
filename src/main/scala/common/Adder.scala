package common

import chisel3._
import chisel3.experimental.MultiIOModule
import config.config

class Adder extends MultiIOModule{

  val VELOCITY_MAX: SInt = 0x7f.S

  val io = IO(
    new Bundle {
      val volume = Input(UInt(16.W))
      val samples_in = Input(Vec(config.N_GENERATORS, SInt(16.W)))
      val sample_out = Output(SInt(32.W))
    }
  )
  io.sample_out := (sumVec(io.samples_in) / VELOCITY_MAX) * io.volume

  //def sumVec(v : Vec[SInt]): SInt = Vec(sumAll(v.toList))(0)
  def sumVec(v : Vec[SInt]): SInt = sumAll(v.toList)

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
