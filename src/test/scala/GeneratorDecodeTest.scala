package toplevel

import chisel3._
import Ex0.TestUtils._
import chisel3.iotesters.PeekPokeTester
import communication.GeneratorUpdatePacket
import org.scalatest.{FlatSpec, Matchers}
import toplevel.GeneratorDecoderTest.GeneratorStateDecoderTest

class GeneratorStateDecoder extends Module {
  val io = IO(new Bundle {
    val in = Input(new GeneratorUpdatePacket)
    val out = Output(new GeneratorUpdatePacket)
  })
  io.out := io.in.withEndianSwapped()
}

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

    poke(c.io.in.toBits, BigInt("0000000001000000000000000100000000000000000000000000000000000000000000010000000000000111", 2))

    for (ii <- 0 until 100) {

      printf("generator_index: %d, packetOut: %d\n", peek(c.io.out.generator_index).asUInt(), peek(c.io.out.data.asUInt()).asUInt())
      step(1)
    }
  }
}
