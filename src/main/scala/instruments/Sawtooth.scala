package instruments

import chisel3._
import chisel3.experimental.MultiIOModule
import sadie.config.config

class Sawtooth extends MultiIOModule {

  val io = IO(
    new Bundle {
      val wavelength = Input(UInt())
      val wavelength_pos = Input(UInt())
      val note_life = Input(UInt())

      val sample_out = Output(SInt())
    }
  )

  io.sample_out := ((((io.wavelength_pos) << 1) - io.wavelength) * config.SAMPLE_MAX.S) / io.wavelength.asSInt()


}
