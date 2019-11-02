package sadie

import Ex0.TestUtils._
import chisel3.iotesters.PeekPokeTester
import chisel3.util.BitPat
import org.scalatest.{FlatSpec, Matchers}
import sadie.I2sTests.MatchingI2sTest

class I2STest extends FlatSpec with Matchers {
  behavior of "i2s"

  it should "Match the I2S protocol out" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new i2s()) { c =>
        new MatchingI2sTest(c)
      } should be(true)
    )
  }


}

object I2sTests {

  val rand = new scala.util.Random(100)

  class MatchingI2sTest(c: i2s) extends PeekPokeTester(c) {
    var sample = 15727680
    poke(c.io.SampleIn, sample)

    for (i <- 0 until 2 * 64 * 44100) {
      printf("i2s output: DataBitOut: %d, SystemClock: %d, LeftRightWordClock: %d, BitClock: %d\n", peek(c.io.DataBit), peek(c.io.SystemClock), peek(c.io.LeftRightWordClock), peek(c.io.BitClock))
      if(i % (440 * 64 * 2) == 0) {
        sample = - sample
      }
      step(34)
    }
  }
}
