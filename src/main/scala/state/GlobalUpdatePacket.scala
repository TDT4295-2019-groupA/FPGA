package state

import chisel3._

class GlobalUpdatePacket extends Bundle {

  val globalUpdatePacket = UInt(200.W)

  def volume = globalUpdatePacket(15, 0)
  def envelope = globalUpdatePacket(71, 16)
  def pitchwheel = globalUpdatePacket(199, 72)

}
