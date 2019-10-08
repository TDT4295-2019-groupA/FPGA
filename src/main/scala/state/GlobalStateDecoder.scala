package state

import chisel3._
import chisel3.experimental.MultiIOModule

class GlobalStateDecoder extends MultiIOModule {

  val io = IO(
    new Bundle {
      val packetIn = Input(new GlobalUpdatePacket)
      val writeEnable = Input(Bool())

      val volumeOut = Output(UInt(16.W))
      val envelopeOut = Output(new Envelope)
      val pitchWheelOut = Output(new PitchWheelArray)
    }
  )

  val volumeReg = RegInit(UInt(16.W), 0.U)
  val envelopeReg = RegInit(new Envelope, Envelope.DEFAULT)
  val pitchWheelReg = RegInit(new PitchWheelArray, PitchWheelArray.DEFAULT)

  when(io.writeEnable) {
    volumeReg := io.packetIn.volume
    envelopeReg := io.packetIn.envelope
    pitchWheelReg := io.packetIn.pitchwheel
  }

  io.volumeOut := volumeReg
  io.envelopeOut := envelopeReg
  io.pitchWheelOut := pitchWheelReg

  //printf("Current Global State: VolumeOut: %d, EnvelopeOut: %d, PitchWheelOut: %d\n", VolumeReg.asUInt(), EnvelopeReg.asUInt(), PitchWheelReg.asUInt())
}
