package generator

import chisel3._

class GeneratorPacket extends Bundle{

  val generatorInput = UInt(72.W)

  def enabled = generatorInput(0).toBool()
  def instrument = generatorInput(39, 8)
  def note_index = generatorInput(47, 40)
  def channel_index = generatorInput(55, 48)
  def velocity = generatorInput(63, 56)
  def reset_note = generatorInput(64).toBool()
}

