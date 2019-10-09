package toplevel

import Ex0.TestUtils._
import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}
import state.GlobalStateDecoder
import toplevel.DecoderTests.GlobalStateDecoderTest

class DecodeTest extends FlatSpec with Matchers {
  behavior of "Decoders"

  it should "Decode Global Packets Correctly" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new GlobalStateDecoder()) { c =>
        new GlobalStateDecoderTest(c)
      } should be(true)
    )
  }
}

object DecoderTests {

  val rand = new scala.util.Random(100)

  class GlobalStateDecoderTest(c: GlobalStateDecoder) extends PeekPokeTester(c) {
    println("Testing that it runs at all")

    /*
    This is a really large packet (248 bits). Just ensure it updates correctly
    Volume = 0-128 (64 for this) = 00000001 00000000
    Envelope = Form of envelope, ensure it matches. For this:
    11001100 10101010 10101010 00011100 00011100 11001100 10101010
    Pitchwheel = A set of 16 pitchwheels, really really big. Just ensure it updates correctly
    11110000 11100011 11001100 10101010 11110000 11100011 11001100 10101010 11110000 11100011 11001100 10101010 11110000 11100011 11001100 10101010
    In total:

    11110000111000111100110010101010111100001110001111001100101010101111000011100011110011001010101011110000111000111100110010101010110011001010101010101010000111000001110011001100101010100000000100000000
    */

    poke(c.io.packetIn.toBits, BigInt("11110000111000111100110010101010111100001110001111001100101010101111000011100011110011001010101011110000111000111100110010101010110011001010101010101010000111000001110011001100101010100000000100000000", 2))
    poke(c.io.writeEnable, true)
    step(1)
    poke(c.io.packetIn.toBits, 0)
    poke(c.io.writeEnable, false)

    for (ii <- 0 until 100) {
      printf("Volume: %d, Envlope: %d, PitchWheel: %d\n", peek(c.io.volumeOut), peek(c.io.envelopeOut.asUInt()), peek(c.io.pitchWheelOut.asUInt()))
      step(1)
    }
  }
}
