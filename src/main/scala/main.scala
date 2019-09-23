package Ex0
import chisel3._
import chisel3.core.withClockAndReset
import chisel3.experimental.RawModule
import generator._
import java.io.File

object main {
  def main(args: Array[String]): Unit = {
    return; // we be dumpin now
    val s = """
    | Attempting to "run" a chisel program is rather meaningless.
    | Instead, try running the tests, for instance with "test" or "testOnly Examples.MyIncrementTest
    |
    | If you want to create chisel graphs, simply remove this message and comment in the code underneath
    | to generate the modules you're interested in.
    """.stripMargin
    println(s)
  }

  // Uncomment to dump .fir file
  // val f = new File("synthesizer/FPGATopLevel.fir")
  // chisel3.Driver.dumpFirrtl(chisel3.Driver.elaborate(() => new FPGATopLevel()), Option(f))

  //val f = new File("synthesizer/VivadoTest.fir")
  //chisel3.Driver.dumpFirrtl(chisel3.Driver.elaborate(() => new VivadoTest()), Option(f))

  val f = new File("synthesizer/TopModule.fir")
  chisel3.Driver.dumpFirrtl(chisel3.Driver.elaborate(() => new TopModule), Option(f))
}

// Here we isntantiate VivadoTest with the reset button being active low
class TopModule extends RawModule {
  val clock = IO(Input(Clock()))
  val reset = IO(Input(Bool()))
  val io = IO(new VivadoTestBundle)

  withClockAndReset(clock, !reset) {
    val vivado_test = Module(new VivadoTest)
    vivado_test.io <> io
  }
}
