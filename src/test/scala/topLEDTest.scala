package sadie.generator

import Ex0.TestUtils._
import chisel3.iotesters.PeekPokeTester
import chisel3.util.BitPat
import org.scalatest.{FlatSpec, Matchers}
import sadie.Top
import sadie.generator.topTests.{basicTopTest, i2sTopTest}

class topLEDTest extends FlatSpec with Matchers {


  behavior of "top with leds"

  /*

  it should "flip the fucking led" in {
  wrapTester(
  chisel3.iotesters.Driver(() => new Top()) { c =>
  new basicTopTest(c)
} should be(true)
  )
}
   */
  it should "write out sensible data" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new Top()) { c =>
        new i2sTopTest(c)
      } should be(true)
    )
  }


}

object topTests {
  class i2sTopTest(c: Top) extends PeekPokeTester(c) {
    println("Test compiled, running")
    for (i <- 0 to 192) {
      printf("BitClock: %d, LRCK: %d, DataOut: %d \n", peek(c.io.BitClock), peek(c.io.LeftRightWordClock), peek(c.io.DataBit))
      step(1)
    }
  }


  class basicTopTest(c: Top) extends PeekPokeTester(c) {
    println("Testing that it runs at all")
    for (i <- 0 to 160) {
      //printf("LED1: %d, LED2: %d, LED3: %d\n", peek(c.io.gpio), peek(c.io.gpio2), peek(c.io.gpio3))
      step(1)
    }
  }
}
