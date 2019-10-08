package toplevel

import java.io.File

import Ex0.TestUtils._
import chisel3.iotesters.PeekPokeTester
import chisel3.util.BitPat
import generator.SoundTopLevel
import org.scalatest.{FlatSpec, Matchers}
import toplevel.TopLevelTests.{BasicTopLevelTest, PlayingMidiTest}

import scala.io.Source

class TopLevelTest extends FlatSpec with Matchers {


  behavior of "Generator"

  it should "Run the pipeline correctly" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new SoundTopLevel()) { c =>
        new PlayingMidiTest(c)
      } should be(true)
    )
  }


}

object TopLevelTests {

  val rand = new scala.util.Random(100)

  class BasicTopLevelTest(c: SoundTopLevel) extends PeekPokeTester(c) {
    println("Testing that it runs at all")

    /*
    Her skal du teknisk sette bare trenge å sette inn et input, så skal det gå gjennom
    Du kan enten sende en GeneratorStateDecoderPacket eller en GlobalStateDecoderPacket
    Preface den med koden tilsvarende hva du sender inn, ie Gen = 1 og Glo = 2
    Se på andre tester for hvordan pakkene skal se ut
    Glo packet = 1 = 00000001
    Gen packet = 2 = 00000010

    Eksempel Gen = 00000000010000000000000001000000000000000000000000000000000000000000000100000010
    Eksempel Glo = 1111000011100011110011001010101011110000111000111100110010101010111100001110001111001100101010101111000011100011110011001010101011001100101010100001110011001100101010100001110011001100101010100001110011001100101010100001110011001100101010100100000000000001

     */

    //poke(c.io.spiPacketIn, BigInt("1111000011100011110011001010101011110000111000111100110010101010111100001110001111001100101010101111000011100011110011001010101011001100101010100001110011001100101010100001110011001100101010100001110011001100101010100001110011001100101010100100000000000001", 2))
    step(1)
    printf("Current State: packet_select: %d, generator_index: %d, volume_out: %d, envelope_out: %d, pitchwheel_out: %d, generator_out: %d, sound_out: %d\n",
      peek(c.debug.packet_select),
      peek(c.debug.note_index),
      peek(c.debug.volume_out),
      peek(c.debug.envelope_out),
      peek(c.debug.pitchwheel_out),
      peek(c.debug.gen7_out),
      peek(c.io.resultOut))
    //poke(c.io.spiPacketIn, BigInt("000000000100000000000000010000000000000000000000000000000000000000000001000000000000011100000010", 2))
    step(1)
    printf("Current State: packet_select: %d, generator_index: %d, volume_out: %d, envelope_out: %d, pitchwheel_out: %d, generator_out: %d, sound_out: %d\n",
      peek(c.debug.packet_select),
      peek(c.debug.note_index),
      peek(c.debug.volume_out),
      peek(c.debug.envelope_out),
      peek(c.debug.pitchwheel_out),
      peek(c.debug.gen7_out),
      peek(c.io.resultOut))
    //Reset input to ensure it doenst update state when it's not supposed to
    //poke(c.io.spiPacketIn.toBits, 0)
    for (ii <- 0 until 100) {
      step(1)
      printf("Current State: packet_select: %d, generator_index : %d, volume_out: %d, envelope_out: %d, pitchwheel_out: %d, generator_out: %d, sound_out: %d\n",
        peek(c.debug.packet_select),
        peek(c.debug.note_index),
        peek(c.debug.volume_out),
        peek(c.debug.envelope_out),
        peek(c.debug.pitchwheel_out),
        peek(c.debug.gen7_out),
        peek(c.io.resultOut))
    }
  }

  class PlayingMidiTest(c: SoundTopLevel) extends PeekPokeTester(c) {
    val filename = "src/test/scala/testdata.txt"

    println(new File((".")).getAbsolutePath)
    for (line <- Source.fromFile(filename).getLines()) {
      //poke(c.io.spiPacketIn, BigInt(line))
      step(1)
      printf("Current State: packet_select: %d, generator_index : %d, volume_out: %d, envelope_out: %d, pitchwheel_out: %d, generator_out: %d, sound_out: %d\n",
        peek(c.debug.packet_select),
        peek(c.debug.note_index),
        peek(c.debug.volume_out),
        peek(c.debug.envelope_out),
        peek(c.debug.pitchwheel_out),
        peek(c.debug.gen7_out),
        peek(c.io.resultOut))
    }
  }
}
