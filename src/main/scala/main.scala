package sadie

import chisel3._
import chisel3.core.withClockAndReset
import chisel3.experimental.RawModule
import java.io.File
import sadie.communication.SPIInputHandler
import sadie.generator._
import sadie.toplevel.SoundTopLevel

object main {
  def main(args: Array[String]): Unit = {
    if (args.length > 1) {
      val top_module = args(0)
      val out_path = args(1)
      val f = new File(out_path)
      chisel3.Driver.dumpFirrtl(args(0) match {
        case "SoundTopLevel"   => chisel3.Driver.elaborate(() => new SoundTopLevel)
        case "VivadoTest"      => chisel3.Driver.elaborate(() => new VivadoTest)
        case "TopModule"       => chisel3.Driver.elaborate(() => new TopModule)
        case "SPIInputHandler" => chisel3.Driver.elaborate(() => new SPIInputHandler)
        case "TestA"           => chisel3.Driver.elaborate(() => new TestA)
      }, Option(f))
      println("Results written to " + out_path)
    } else {
      val s = """
      | Attempting to "run" a chisel program alone is rather meaningless.
      | Pass in as a parameter which top level module you'd like to dump as firrtl and where to dump it:
      |     run VivadoTest synthesizer/VivadoTest.fir
      |
      | Otherwise, try running the tests, for instance with "test" or "testOnly Examples.MyIncrementTest
      """.stripMargin
      println(s)
    }
  }
}

// Here we instantiate Top with the reset button flipped
class TopModule extends RawModule {
  val clock = IO(Input(Clock()))
  val reset = IO(Input(Bool()))
  val io = IO(new TopBundle)
  val fake_reset = Wire(Bool())
  withClockAndReset(clock, false.B) {
    val hold_reset = RegNext(false.B)
    val flip_reset = RegNext(false.B)
    flip_reset := flip_reset
    hold_reset := hold_reset
  
    when (!hold_reset && !flip_reset) {
      flip_reset := true.B
      hold_reset := true.B
    }
    when (hold_reset && flip_reset) {
      flip_reset := false.B
    }
    fake_reset := flip_reset
  }
  withClockAndReset(clock, fake_reset) {
    val top = Module(new Top)
    top.io <> io
  }
}
