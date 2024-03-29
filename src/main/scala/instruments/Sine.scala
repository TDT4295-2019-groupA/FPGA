package instruments

import chisel3._
import chisel3.experimental.MultiIOModule
import sadie.config.config

class Sine extends MultiIOModule{

  val io = IO(
    new Bundle {
      val wavelength = Input(UInt())
      val wavelength_pos = Input(UInt())
      val note_life = Input(UInt())

      val sample_out = Output(SInt())
    }
  )

  //See: https://en.wikipedia.org/wiki/Bhaskara_I%27s_sine_approximation_formula
  val angleValue = Wire(SInt())
  angleValue := 2.S * 314.S * io.note_life / io.wavelength.asSInt()
  io.sample_out := config.SAMPLE_MAX.asSInt() * ((4.S * angleValue * (180.S - angleValue)) / (40500.S - angleValue * (180.S - angleValue))).asSInt()

}
