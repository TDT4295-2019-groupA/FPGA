package generator

import chisel3._
import chisel3.util._
import chisel3.experimental.MultiIOModule

class TestB() extends MultiIOModule {
  val io = IO(new Bundle {
    val a = Input(Bool())
    val b = Output(Bool())
  })
  io.b := ! io.a
}


class TestA() extends MultiIOModule {
  val io = IO(new Bundle {
    val a = Input(Bool())
    val b = Output(Bool())
  })

  val testb1 = Module(new TestB).io
  val testb2 = Module(new TestB).io
  val testb3 = Module(new TestB).io

  testb1.a := io.a
  testb2.a := testb1.b
  testb3.a := testb2.b
  io.b     := testb3.b

}
