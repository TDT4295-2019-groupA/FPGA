package sadie.generator

import Ex0.TestUtils._
import chisel3.iotesters.PeekPokeTester
import chisel3.util.BitPat
import generator.MinimalGenerator
import org.scalatest.{FlatSpec, Matchers}
import sadie.communication.{GeneratorUpdate, GlobalUpdate}

class GeneratorTest extends FlatSpec with Matchers {

  import GeneratorTests._

  behavior of "Generator"

  it should "Set up and calculate correctly" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new MinimalGenerator()) { c =>
        new BasicGeneratorTest(c)
      } should be(true)
    )
  }


}

object GeneratorTests {

  val rand = new scala.util.Random(100)

  class BasicGeneratorTest(c: MinimalGenerator) extends PeekPokeTester(c) {
    println("Testing that it runs at all")

    /*
    For standard input:
    Reset_Note = false. 00000000
    Enabled = true. 00000001
    Instrument = Square. 00000000
    Note_index = ~ 50 - 70. 01000000 (64)
    Channel_index = 0. 00000000
    Velocity = ~ 50 - 70.  01000000 (64)
    Preface with 1 to not drop any bits.
    00000000 00000001 00000000 01000000 00000000 01000000
    In total realendian: "000000000000000100000000010000000000000001000000"
    */

    //Currently not used
    //val genPackIn = (BitPat.bitPatToUInt(BitPat("000000000000000100000000010000000000000001000000")))

    //Writeenable has to be set
    poke(c.io.generator_update_valid, true)
    poke(c.io.step_sample, false)
    poke(c.io.generator_update.unused, 0)
    poke(c.io.generator_update.reset_note, false)
    poke(c.io.generator_update.unused2, 0)
    poke(c.io.generator_update.enabled, true)
    poke(c.io.generator_update.instrument, 0)
    poke(c.io.generator_update.note_index, 60)
    poke(c.io.generator_update.channel_index, 0)
    poke(c.io.generator_update.velocity, 127)
    poke(c.io.generator_num, 1)
    //I think it defaults to 0.U anyway, so this is prob pointless
    poke(c.io.global_config.envelope.attack, 0)
    poke(c.io.global_config.envelope.decay, 0)
    poke(c.io.global_config.envelope.release, 0)
    poke(c.io.global_config.envelope.sustain, 0)
    poke(c.io.global_config.pitchwheels(0), 0)
    poke(c.io.global_config.pitchwheels(1), 0)
    poke(c.io.global_config.pitchwheels(2), 0)
    poke(c.io.global_config.pitchwheels(3), 0)
    poke(c.io.global_config.pitchwheels(4), 0)
    poke(c.io.global_config.pitchwheels(5), 0)
    poke(c.io.global_config.pitchwheels(6), 0)
    poke(c.io.global_config.pitchwheels(7), 0)
    poke(c.io.global_config.volume, 127)
    step(1)
    //Reset input to ensure it doenst update state when it's not supposed to
    poke(c.io.generator_update_valid, false)
    poke(c.io.step_sample, true)
    for (ii <- 0 until 100) {
      printf("Sound output: %d\n", peek(c.io.sample_out))
      step(1)
    }
  }
}
