package state

import chisel3._
import chisel3.util.BitPat

class Envelope extends Bundle {

  val envelope = UInt(112.W)

  def attack = envelope(31, 0)
  def decay = envelope(63, 32)
  def sustain = envelope(79, 64)
  def release = envelope(111, 80)
}

//TODO: Fix default implementation
object Envelope {
  def DEFAULT: Envelope = {
    val w = Wire(new Envelope)
    w.envelope := BitPat.bitPatToUInt(BitPat("b00000000000000000000000000010011"))
    w
  }
}