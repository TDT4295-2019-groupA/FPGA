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

      val sample_out = Output(SInt(16.W))
    }
  )

  //See: https://en.wikipedia.org/wiki/Bhaskara_I%27s_sine_approximation_formula
/*
  val angleValue = Wire(SInt())
  angleValue := 2.S * 314.S * io.note_life / io.wavelength.asSInt()
  io.sample_out := config.SAMPLE_MAX.asSInt() * ((4.S * angleValue * (180.S - angleValue)) / (40500.S - angleValue * (180.S - angleValue))).asSInt()
*/

  val angleValue = Wire(SInt(12.W))
  angleValue := ((2 * 314).U * io.wavelength_pos / io.wavelength).asSInt()

  val part1 = Wire(SInt(24.W))
  //val part1 = Reg(SInt(24.W)) // pipelining
  part1 := angleValue * (180.S - angleValue)

  io.sample_out := config.SAMPLE_MAX.S * (
    (
      4.S * part1
    ) / (
      40500.S - part1
    )
  )

}
