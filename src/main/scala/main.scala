package Ex0
import chisel3._
import chisel3.core.withClockAndReset
import chisel3.experimental.RawModule
import generator._
import java.io.File

object main {
  def main(args: Array[String]): Unit = {
    if (args.length > 1) {
      val top_module = args(0)
      val out_path = args(1)
      val f = new File(out_path)
      chisel3.Driver.dumpFirrtl(args(0) match {
        case "FPGATopLevel" => chisel3.Driver.elaborate(() => new FPGATopLevel())
        case "VivadoTest"   => chisel3.Driver.elaborate(() => new VivadoTest())
        case "TopModule"    => chisel3.Driver.elaborate(() => new TopModule)
      }, Option(f))
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

// Here we instantiate VivadoTest with the reset button flipped
class TopModule extends RawModule {
  val clock = IO(Input(Clock()))
  val reset = IO(Input(Bool()))
  val io = IO(new VivadoTestBundle)

  withClockAndReset(clock, !reset) {
    val vivado_test = Module(new VivadoTest)
    vivado_test.io <> io
  }
}
