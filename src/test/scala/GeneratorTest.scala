package generator

import Ex0.TestUtils._
import chisel3.iotesters.PeekPokeTester
import chisel3.util.BitPat
import generator.GeneratorPacket
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
  import generator._

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
    ""
    In total ""
    */

    val genPackIn = (BitPat.bitPatToUInt(BitPat("b000000000100000000000000010000000000000000000000000000000000000000000001")))

    poke(c.io.writeEnable, true)
    poke(c.io.generatorPacketIn.toBits, BigInt("000000000100000000000000010000000000000000000000000000000000000000000001", 2))

    poke(c.io.envelopeIn.toBits, 0)
    poke(c.io.pitchWheelArrayIn.toBits, 0)

    step(1)
    for (ii <- 0 until 100) {
      poke(c.io.generatorPacketIn.toBits, BigInt("000000000100000000000000010000000000000000000000000000000000000000000001", 2))
      printf("Sound output: %d\n", peek(c.io.sampleOut))
      //printf("PacketIn/Out: %d\n", peek(c.io.outputTest))
      step(1)
    }
  }
}
