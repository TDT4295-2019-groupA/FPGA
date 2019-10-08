package generator

import chisel3._
import chisel3.Bundle

class GeneratorUpdatePacket extends Bundle {
  val generatorUpdatePacket = UInt(88.W)

  def generator_index = generatorUpdatePacket(15, 0)
  def generator_packet = generatorUpdatePacket(87, 16).asTypeOf(new GeneratorPacket)
}
