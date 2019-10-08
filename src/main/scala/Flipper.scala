package toplevel

import chisel3.experimental.MultiIOModule
import chisel3._
import generator.GeneratorUpdatePacket
import state.GlobalUpdatePacket

class Flipper extends MultiIOModule{

  val io = IO(
    new Bundle{
      val packetIn = Input(UInt(208.W))

      val soundOut = Output(SInt(32.W))
    }
  )

  val debug = IO(
    new Bundle {
      val generator_index = Output(UInt(16.W))
      val volume_out = Output(UInt(16.W))
      val envelope_out = Output(UInt(72.W))
      val pitchwheel_out = Output(UInt(128.W))
      val gen7_out = Output(SInt(32.W))
    }
  )

  val soundTopLevel = Module(new SoundTopLevel)

  when(io.packetIn(7,0) === 1.U) {
    soundTopLevel.io.gloWriteEnable := true.B
    soundTopLevel.io.gloPacketIn := io.packetIn(207, 8).asTypeOf(new GlobalUpdatePacket)
    soundTopLevel.io.genPacketIn := 0.U.asTypeOf(new GeneratorUpdatePacket)
  }.elsewhen(io.packetIn(7,0) === 2.U) {
    soundTopLevel.io.genPacketIn := io.packetIn(95, 8).asTypeOf(new GeneratorUpdatePacket)
    soundTopLevel.io.gloPacketIn := 0.U.asTypeOf(new GlobalUpdatePacket)
    soundTopLevel.io.gloWriteEnable := false.B
  }.otherwise {
    soundTopLevel.io.genPacketIn := 0.U.asTypeOf(new GeneratorUpdatePacket)
    soundTopLevel.io.gloPacketIn := 0.U.asTypeOf(new GlobalUpdatePacket)
    soundTopLevel.io.gloWriteEnable := false.B
  }

  debug.generator_index := soundTopLevel.debug.note_index
  debug.volume_out := soundTopLevel.debug.volume_out
  debug.envelope_out := soundTopLevel.debug.envelope_out
  debug.pitchwheel_out := soundTopLevel.debug.pitchwheel_out
  debug.gen7_out := soundTopLevel.debug.gen7_out
  io.soundOut := soundTopLevel.io.resultOut

  chisel3.printf("Testing stuff: Input: %b\n", io.packetIn)

}
