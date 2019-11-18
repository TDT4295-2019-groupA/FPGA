package sadie.toplevel

import java.io.File
import java.nio.ByteBuffer

import Ex0.TestUtils._
import chisel3.iotesters.PeekPokeTester
import chisel3.iotesters._
import chisel3.util.BitPat
import org.scalatest.Assertions._
import org.scalatest.{FlatSpec, Matchers}
import sadie.config.config

import scala.io.Source


class SoundTopLevelTest extends FlatSpec with Matchers {

  behavior of "Generator"

/*
  it should "Play square waves" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new SoundTopLevel()) { c =>
        new SoundTopLevelTests.PlayingSquareTest(c)
      } should be(true)
    )
  }
*/
/*
  it should "Play music" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new SoundTopLevelPeekPokeWrapper()) { c =>
        new SoundTopLevelTests.TestSPIEventsFromFile(c, "src/test/resources/input_data/sootopolis_spi.txt", false)
      } should be(true)
    )
  }
*/
  it should "Match reference implementation data" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new SoundTopLevelPeekPokeWrapper()) { c =>
        new SoundTopLevelTests.TestSPIEventsFromFile(c, "src/test/resources/input_data/sootopolis_spi.txt", true)
      } should be(true)
    )
  }


}

object SoundTopLevelTests {
  val rand = new scala.util.Random(100)

  class PlayingSquareTest(c: SoundTopLevel) extends PeekPokeTester(c) {
    poke(c.io.global_update_packet.data.volume, 0xff)
    poke(c.io.global_update_packet.data.envelope.attack,  0x0000)
    poke(c.io.global_update_packet.data.envelope.decay,   0x0000)
    poke(c.io.global_update_packet.data.envelope.sustain, 0xff)
    poke(c.io.global_update_packet.data.envelope.release, 0x0000)
    for (i <- 0 to 15) poke(c.io.global_update_packet.data.pitchwheels(i), 0)
    poke(c.io.global_update_packet_valid, true)
    step(1)
    poke(c.io.global_update_packet_valid, false)

    poke(c.io.generator_update_packet.generator_index, 0)
    poke(c.io.generator_update_packet.data.channel_index, 0x00)
    poke(c.io.generator_update_packet.data.enabled, true)
    poke(c.io.generator_update_packet.data.instrument, 0x00)
    poke(c.io.generator_update_packet.data.note_index, 60)
    poke(c.io.generator_update_packet.data.reset_note, true)
    poke(c.io.generator_update_packet.data.velocity, 0x7f)
    poke(c.io.generator_update_packet_valid, true)
    step(1)
    poke(c.io.generator_update_packet_valid, false)

    for (sample <- 1 to 100) {
      poke(c.io.step_sample, true)
      step(1)
      printf("sample_out1: %d\n", peek(c.io.sample_out))
      poke(c.io.step_sample, false)
      step(1)
      printf("sample_out2: %d\n", peek(c.io.sample_out))
    }
  }
  class TestSPIEventsFromFile(c: SoundTopLevelPeekPokeWrapper, filename:String, val expect_samples:Boolean) extends PeekPokeTester(c) {
    println(new File(filename).getAbsolutePath)

    var samples_made:Int = 0
    for (line <- Source.fromFile(filename).getLines().map(_.stripLineEnd)) {

      if(line.startsWith("Sample:") && expect_samples) {
        val expected_sample = line.split(" ")(1).toInt
        poke(c.io.step_sample, true)
        step(1)
        poke(c.io.step_sample, false)
        expect(c.io.sample_out, expected_sample)
      }
      else if(line.startsWith("Step:") && !expect_samples) {
        val n_samples = line.split(" ")(1).toInt
        printf("Step: %d\n", n_samples)
        for (i <- 1 to n_samples) {
          poke(c.io.step_sample, true)
          step(1)
          poke(c.io.step_sample, false)
          printf("sample_out#%d: %d\n", samples_made, peek(c.io.sample_out))
          samples_made += 1
        }
      }
      else if(line.startsWith("SPI:")) {
        val list_of_hex = line.split(":")(1).split(" ").tail
        val packet_type = Integer.parseInt(list_of_hex(0), 16)
        val packet_data = BigInt(list_of_hex.mkString(""), 16)
        printf("SPI: %x\n", packet_data)

        if (packet_type == config.sGlobalUpdate) {
          poke(c.io.packet_data, packet_data)
          poke(c.io.global_update_packet_valid, true)
          step(1)
          poke(c.io.global_update_packet_valid, false)
        }
        if (packet_type == config.sGeneratorUpdate) {
          poke(c.io.packet_data, packet_data)
          poke(c.io.generator_update_packet_valid, true)
          step(1)
          poke(c.io.generator_update_packet_valid, false)
        }
        if (packet_type == config.sReset) {
          // nothing defined in top.scala for this case so far
        }
      }
      else if (line.startsWith("#generated for SAMPLE_RATE"))     assertResult(config.SAMPLE_RATE,     "SAMPLE_RATE")     { line.split(" ").reverse(0).toInt }
      else if (line.startsWith("#generated for FREQ_SHIFT"))      assertResult(config.FREQ_SHIFT,      "FREQ_SHIFT")      { line.split(" ").reverse(0).toInt }
      else if (line.startsWith("#generated for NOTE_LIFE_COEFF")) assertResult(config.NOTE_LIFE_COEFF, "NOTE_LIFE_COEFF") { line.split(" ").reverse(0).toInt }
      else if (line.startsWith("#generated for N_MIDI_KEYS"))     assertResult(config.N_MIDI_KEYS,     "N_MIDI_KEYS")     { line.split(" ").reverse(0).toInt }
      else if (line.startsWith("#generated for N_MIDI_CHANNELS")) assertResult(config.N_MIDI_CHANNELS, "N_MIDI_CHANNELS") { line.split(" ").reverse(0).toInt }
      else if (line.startsWith("#generated for MIDI_A3_INDEX"))   assertResult(config.MIDI_A3_INDEX,   "MIDI_A3_INDEX")   { line.split(" ").reverse(0).toInt }
      else if (line.startsWith("#generated for MIDI_A3_INDEX"))   assertResult(config.MIDI_A3_INDEX,   "MIDI_A3_INDEX")   { line.split(" ").reverse(0).toInt }
      else if (line.startsWith("#generated for MIDI_A3_FREQ"))    assertResult(config.MIDI_A3_FREQ,    "MIDI_A3_FREQ")    { line.split(" ").reverse(0).toFloat }
      else if (line.startsWith("#generated for VELOCITY_MAX"))    assertResult(config.VELOCITY_MAX,    "VELOCITY_MAX")    { line.split(" ").reverse(0).toInt }
      else if (line.startsWith("#generated for SAMPLE_MAX"))      assertResult(config.SAMPLE_MAX,      "SAMPLE_MAX")      { line.split(" ").reverse(0).toInt }
      else if (line.startsWith("#generated for N_GENERATORS"))    assertResult(config.N_GENERATORS,    "N_GENERATORS")    { line.split(" ").reverse(0).toInt }

    }
  }
}
