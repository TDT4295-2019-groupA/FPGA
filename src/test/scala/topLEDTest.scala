package sadie.generator

import Ex0.TestUtils._
import chisel3.iotesters.PeekPokeTester
import chisel3.util.BitPat
import org.scalatest.{FlatSpec, Matchers}
import sadie.generator.topTests.basicTopTest

class topLEDTest extends FlatSpec with Matchers {


  behavior of "top with leds"

  it should "flip the fucking led" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new Top()) { c =>
        new basicTopTest(c)
      } should be(true)
    )
  }


}

object topTests {
  class basicTopTest(c: Top) extends PeekPokeTester(c) {
    println("Testing that it runs at all")
    for (i <- 0 to 160) {
      printf("LED1: %d, LED2: %d, LED3: %d\n", peek(c.io.gpio), peek(c.io.gpio2), peek(c.io.gpio3))
      step(1)
    }
  }
}
