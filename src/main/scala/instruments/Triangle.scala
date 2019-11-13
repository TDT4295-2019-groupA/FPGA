package instruments

import chisel3._
import chisel3.experimental.MultiIOModule
import sadie.config.config

class Triangle extends MultiIOModule{

  val io = IO(
    new Bundle {
      val wavelength = Input(UInt())
      val wavelength_pos = Input(UInt())
      val note_life = Input(UInt())

      val sample_out = Output(SInt(16.W))
    }
  )

  val half = Wire(UInt())
  val quarter = Wire(UInt())
  val pos = Wire(UInt())

  half := io.wavelength_pos >>1
  quarter := io.wavelength_pos >>2

  when(io.wavelength_pos > (half + quarter)) {
    pos := io.wavelength_pos - (half + quarter)
  }.otherwise {
    pos := io.wavelength_pos + quarter
  }
  io.sample_out := ((pos - half).asUInt() - quarter).asSInt() * config.SAMPLE_MAX.asSInt() / quarter.asSInt()

}
