package generator

import chisel3._
import chisel3.experimental.MultiIOModule
import state.{Envelope, PitchWheelArray}

class Generator extends MultiIOModule{

  val io = IO(
    new Bundle {
      val generatorPacketIn = Input(new GeneratorPacket)
      val envelopeIn = Input(new Envelope)
      val pitchWheelArrayIn = Input(new PitchWheelArray)

      val sampleOut = Output(UInt(16.W))
    }
  )





}
