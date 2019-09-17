package generator

import chisel3._
import chisel3.experimental.MultiIOModule

class GeneratorStateDecoder extends MultiIOModule {

  val io = IO(
    new Bundle {
      val packetIn = Input(UInt(88.W))

      val resetNoteOut = Output(Bool())
      val indexOut = Output(UInt(16.W))

      val GeneratorPacketOut = Output(new GeneratorPacket)
    }
  )

  io.resetNoteOut := io.packetIn(7, 0)
  io.indexOut := io.packetIn(23, 8)

  io.GeneratorPacketOut := io.packetIn(87, 24).asTypeOf(new GeneratorPacket)



}
