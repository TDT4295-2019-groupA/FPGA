package generator

import chisel3._
import chisel3.experimental.MultiIOModule
import chisel3.util.{Counter, is, switch}
import state.{Envelope, PitchWheelArray}

class Generator extends MultiIOModule{

  val io = IO(
    new Bundle {
      val generatorPacketIn = Input(new GeneratorPacket)
      val envelopeIn = Input(new Envelope)
      val pitchWheelArrayIn = Input(new PitchWheelArray)
      val writeEnable = Input(Bool())

      val sampleOut = Output(UInt(16.W))
    }
  )
  val noteLife = RegInit(UInt(32.W), 0.U)
  val enabled = RegInit(Bool(), false.B)
  val instrument = RegInit(UInt(8.W), InstrumentEnum.SQUARE)
  val note_index = RegInit(UInt(8.W), 0.U)
  val velocity = RegInit(UInt(8.W), 0.U)

  when(io.writeEnable) {
    enabled := io.generatorPacketIn.enabled
    instrument := io.generatorPacketIn.instrument
    note_index := io.generatorPacketIn.note_index
    velocity := io.generatorPacketIn.velocity
  } otherwise {
    enabled := enabled
    instrument := instrument
    note_index := note_index
    velocity := velocity
  }


  when(io.generatorPacketIn.reset_note) {
    noteLife := 0.U
  } otherwise {
    noteLife := noteLife + 1.U
  }

  switch(io.generatorPacketIn.instrument) {
    is(InstrumentEnum.SQUARE) {

    }
    is(InstrumentEnum.TRIANGLE) {

    }
    is(InstrumentEnum.SAWTOOTH) {

    }
    is(InstrumentEnum.SINE) {

    }
  }

  when(io.generatorPacketIn.enabled) {
    io.sampleOut := result
  } otherwise {
    io.sampleOut := 0.U
  }
}

object InstrumentEnum extends Enumeration {
  type InstrumentEnum = UInt
  val SQUARE = 0.U
  val TRIANGLE = 1.U
  val SAWTOOTH = 2.U
  val SINE = 3.U
}
