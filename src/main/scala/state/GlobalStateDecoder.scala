package state

import chisel3._
import chisel3.experimental.MultiIOModule

class GlobalStateDecoder extends MultiIOModule {

  val io = IO(
    new Bundle {
      val packetIn = Input(UInt(248.W))
      val writeEnable = Input(Bool())

      val volumeOut = Output(UInt(8.W))
      val EnvelopeOut = Output(new Envelope)
      val PitchWheelOut = Output(new PitchWheelArray)
    }
  )

  val VolumeReg = RegInit(UInt(8.W), 0.U)
  val EnvelopeReg = RegInit(new Envelope, Envelope.DEFAULT)
  val PitchWheelReg = RegInit(new PitchWheelArray, PitchWheelArray.DEFAULT)

  when(io.writeEnable) {
    VolumeReg := io.packetIn(7, 0)
    EnvelopeReg := io.packetIn(119, 8).asTypeOf(new Envelope)
    PitchWheelReg := io.packetIn(247, 120).asTypeOf(new PitchWheelArray)
  }

  io.volumeOut := VolumeReg
  io.EnvelopeOut := EnvelopeReg
  io.PitchWheelOut := PitchWheelReg

  //printf("Current Global State: VolumeOut: %d, EnvelopeOut: %d, PitchWheelOut: %d\n", VolumeReg.asUInt(), EnvelopeReg.asUInt(), PitchWheelReg.asUInt())
}
