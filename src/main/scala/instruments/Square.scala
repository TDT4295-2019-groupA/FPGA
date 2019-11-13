package instruments

import chisel3._
import chisel3.experimental.MultiIOModule
import sadie.config.config

class Square extends MultiIOModule {

  val io = IO(
    new Bundle {
      val wavelength = Input(UInt())
      val wavelength_pos = Input(UInt())
      val note_life = Input(UInt())

      val sample_out = Output(SInt(16.W))
    }
  )

  when ((io.wavelength_pos << 1.U) > io.wavelength) {
    io.sample_out := (-config.SAMPLE_MAX).S
  } otherwise {
    io.sample_out := config.SAMPLE_MAX.S
  }

}
