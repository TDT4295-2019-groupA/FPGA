package generator

import chisel3._
import chisel3.experimental.MultiIOModule

class GeneratorStateDecoder extends MultiIOModule {

  val io = IO(
    new Bundle {
      val packetIn = Input(UInt(88.W))
      val indexOut = Output(UInt(16.W))

      val GeneratorPacketOut = Output(new GeneratorPacket)
    }
  )

  io.indexOut := io.packetIn(15, 0)

  io.GeneratorPacketOut := io.packetIn(87, 16).asTypeOf(new GeneratorPacket)

}
