package state

import chisel3._
import chisel3.util.BitPat

class Envelope extends Bundle {

  /*
  See the SPI packet details to understand this: https://github.com/TDT4295-2019-groupA/planning/wiki/SPI-packets
  Currently: Attack: 2 bytes, Decay: 2 bytes, Sustain: 1 byte, Release: 2 bytes. Total: 7 bytes = 56 bits
   */

  val envelope = UInt(56.W)

  def attack = envelope(15, 0)
  def decay = envelope(31, 16)
  def sustain = envelope(39, 32)
  def release = envelope(55, 40)
}



//TODO: Fix default implementation
object Envelope {
  def DEFAULT: Envelope = {
    val w = Wire(new Envelope)
    w.envelope := BitPat.bitPatToUInt(BitPat("b00000000000000000000000000010011"))
    w
  }
}