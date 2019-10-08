package generator

import chisel3._
import chisel3.experimental.MultiIOModule

class GeneratorStateDecoder extends MultiIOModule {

  val io = IO(
    new Bundle {
      val packetIn = Input(new GeneratorUpdatePacket)
      val indexOut = Output(UInt(16.W))

      val GeneratorPacketOut = Output(new GeneratorPacket)
    }
  )

  io.indexOut := io.packetIn.generator_index

  io.GeneratorPacketOut := io.packetIn.generator_packet

}
