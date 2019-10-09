package Ex0
import chisel3._
import chisel3.core.withClockAndReset
import chisel3.experimental.RawModule
import generator._
import communication.SPIInputHandler
import java.io.File

import toplevel.SoundTopLevel

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

  withClockAndReset(clock, !reset) {
    val top = Module(new Top)
    top.io <> io
  }
}
