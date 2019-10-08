package toplevel

import Ex0.TestUtils._
import chisel3.iotesters.PeekPokeTester
import generator.GeneratorStateDecoder
import org.scalatest.{FlatSpec, Matchers}
import toplevel.GeneratorDecoderTest.GeneratorStateDecoderTest

class GeneratorDecodeTest extends FlatSpec with Matchers {
  behavior of "Decoders"

  it should "Decode Generator Packets Correctly" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new GeneratorStateDecoder()) { c =>
        new GeneratorStateDecoderTest(c)
      } should be(true)
    )
  }
}

object GeneratorDecoderTest {

  val rand = new scala.util.Random(100)

  class GeneratorStateDecoderTest(c: GeneratorStateDecoder) extends PeekPokeTester(c) {

    /*
    index: 16 bits - 7 (00000000 00000111)
    GeneratorPacketIn: See GeneratorTest
    0000000001000000000000000100000000000000000000000000000000000000000000010000000000000111

     */

    poke(c.io.packetIn.toBits, BigInt("0000000001000000000000000100000000000000000000000000000000000000000000010000000000000111", 2))

    for (ii <- 0 until 100) {
      printf("indexOut: %d, packetOut: %d\n", peek(c.io.indexOut), peek(c.io.GeneratorPacketOut.asUInt()))
      step(1)
    }
  }
}
