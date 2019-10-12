package sadie.config

import chisel3._

// tweakable constants
object config {
  val FREQ_SHIFT      = 12     // scaling factor (bit shifts) when dealing with frequencies
  val NOTE_LIFE_COEFF = 10     // scaling factor when representing noteLife and wavelength as an integer
  val MIDI_A3_FREQ    = 440.0  // i won't listen to your a=432Hz bullshit
  //val MIDI_A3_INDEX   = 45
  val MIDI_A3_INDEX   = 58     // this sounds better *lenny face*
  val N_GENERATORS    = 16
  val N_MIDI_CHANNELS = 16     // max amount of channels supported by the MIDI standard
  val N_MIDI_KEYS     = 128    // max amount of keys supported by the MIDI standard
  val SAMPLE_MAX      = 0x7FFF // max output from a single generator
  val SAMPLE_RATE     = 44100  // target samplerate, we control the clock though
  val VELOCITY_MAX    = 0x7f   // max velocity supported by the MIDI standard
  val FPGA_CLOCK_SPEED = 100000000 // 100MHz

  // MAGIC identifier for SPI packets
  val sReset           = 0
  val sGlobalUpdate    = 1
  val sGeneratorUpdate = 2

  // SPI packet lengths
  val GlobalUpdateLength    = 25 // bytes
  val GeneratorUpdateLength = 12 // bytes

  object InstrumentEnum extends Enumeration {
    type InstrumentEnum = UInt
    val SQUARE: UInt = 0.U
    val TRIANGLE: UInt = 1.U
    val SAWTOOTH: UInt = 2.U
    val SINE: UInt = 3.U
  }
}
