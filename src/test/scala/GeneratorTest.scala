package generator

import Ex0.TestUtils._
import chisel3.iotesters.PeekPokeTester
import chisel3.util.BitPat
import org.scalatest.{FlatSpec, Matchers}

class GeneratorTest extends FlatSpec with Matchers {

  import GeneratorTests._

  behavior of "Generator"

  it should "Set up and calculate correctly" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new Generator()) { c =>
        new BasicGeneratorTest(c)
      } should be(true)
    )
  }


}

object GeneratorTests {

  val rand = new scala.util.Random(100)

  class BasicGeneratorTest(c: Generator) extends PeekPokeTester(c) {
    println("Testing that it runs at all")

    /*
    For standard input:
    Enabled = true. 00000001
    Instrument = Square. 00000000 00000000 00000000 00000000
    Note_index = ~ 50 - 70. 01000000 (64)
    Channel_index = 0. 00000000
    Velocity = ~ 50 - 70.  01000000 (64)
    Reset_Note = false. 00000000
    Preface with 1 to not drop any bits.
    00000000 01000000 00000000 01000000 00000000 00000000 000000000 00000000 000000
    In total realendian: "000000000100000000000000010000000000000000000000000000000000000000000001"
    */

    //Currently not used
    //val genPackIn = (BitPat.bitPatToUInt(BitPat("b000000000100000000000000010000000000000000000000000000000000000000000001")))

    //Writeenable has to be set
    poke(c.io.generator_update_valid, true)
    poke(c.io.generator_update.toBits, BigInt("000000000100000000000000010000000000000000000000000000000000000000000001", 2))
    //I think it defaults to 0.U anyway, so this is prob pointless
    poke(c.io.global_config.envelope.toBits, 0)
    poke(c.io.global_config.pitchwheels.toBits, 0)
    step(1)
    //Reset input to ensure it doenst update state when it's not supposed to
    poke(c.io.generator_update_valid, false)
    poke(c.io.generator_update.toBits, 0)
    for (ii <- 0 until 100) {
      printf("Sound output: %d\n", peek(c.io.sample_out))
      step(1)

    }
  }
}
