package state

import chisel3._
import chisel3.experimental.MultiIOModule

class GlobalStateDecoder extends MultiIOModule {

  val io = IO(
    new Bundle {
      val packetIn = Input(new GlobalUpdatePacket)
      val writeEnable = Input(Bool())

      val volumeOut = Output(UInt(16.W))
      val EnvelopeOut = Output(new Envelope)
      val PitchWheelOut = Output(new PitchWheelArray)
    }
  )

  val VolumeReg = RegInit(UInt(16.W), 0.U)
  val EnvelopeReg = RegInit(new Envelope, Envelope.DEFAULT)
  val PitchWheelReg = RegInit(new PitchWheelArray, PitchWheelArray.DEFAULT)

  when(io.writeEnable) {
    VolumeReg := io.packetIn.volume
    EnvelopeReg := io.packetIn.envelope
    PitchWheelReg := io.packetIn.pitchwheel
  }

  io.volumeOut := VolumeReg
  io.EnvelopeOut := EnvelopeReg
  io.PitchWheelOut := PitchWheelReg

  //printf("Current Global State: VolumeOut: %d, EnvelopeOut: %d, PitchWheelOut: %d\n", VolumeReg.asUInt(), EnvelopeReg.asUInt(), PitchWheelReg.asUInt())
}
