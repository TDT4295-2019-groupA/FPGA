package sadie.communication

import chisel3._
import chisel3.Bundle
import sadie.common.swapEndian
import sadie.config.config


class Envelope extends Bundle {
  val attack = UInt(16.W)
  val decay = UInt(16.W)
  val sustain = UInt(8.W)
  val release = UInt(16.W)

  def withEndianSwapped() : Envelope = {
    val w = Wire(new Envelope)
    w.attack  := swapEndian(attack)
    w.decay   := swapEndian(decay)
    w.sustain := sustain
    w.release := swapEndian(release)
    return w
  }
}

object Envelope { // TODO, get rid of this?
  def DEFAULT: Envelope = {
    val w = Wire(new Envelope)
    w.attack  := 0x0000.U
    w.decay   := 0x0000.U
    w.sustain := 0xFF.U
    w.release := 0x0000.U
    return w
  }
}

class GlobalUpdatePacket extends Bundle {
  val magic           = UInt(8.W) // === config.sGlobalUpdate.U
  val data            = new GlobalUpdate

  def withEndianSwapped() : GlobalUpdatePacket = {
    val w = Wire(new GlobalUpdatePacket)
    w.magic       := magic
    w.data        := data.withEndianSwapped
    return w
  }
}

class GlobalUpdate extends Bundle {
  val volume          = UInt(8.W)
  val envelope        = new Envelope()
  val pitchwheels     = Vec(SInt(8.W), config.N_MIDI_CHANNELS)

  def withEndianSwapped() : GlobalUpdate = {
    val w = Wire(new GlobalUpdate)
    w.volume      := volume
    w.envelope    := envelope.withEndianSwapped
    w.pitchwheels := Vec(pitchwheels.toList.reverse)
    return w
  }
}

object GlobalUpdate {
  def DEFAULT: GlobalUpdate = {
    val w = Wire(new GlobalUpdate)
    w.volume := 64.U
    w.envelope := Envelope.DEFAULT
    w.pitchwheels := Vec.fill(config.N_MIDI_CHANNELS)(64.S(8.W))
    w
  }
}


class GeneratorUpdatePacket extends Bundle {
  val magic           = UInt(8.W) // === config.sGeneratorUpdate.U
  val generator_index = UInt(16.W)
  val data            = new GeneratorUpdate

  def withEndianSwapped() : GeneratorUpdatePacket = {
    val w = Wire(new GeneratorUpdatePacket)
    w.magic           := magic
    w.generator_index := swapEndian(generator_index)
    w.data            := data.withEndianSwapped
    return w
  }
}

class GeneratorUpdate extends Bundle {
  val unused          = UInt(7.W)
  val reset_note      = Bool()
  val unused2         = UInt(7.W)
  val enabled         = Bool()
  val instrument      = UInt(8.W)
  val note_index      = UInt(8.W)
  val channel_index   = UInt(8.W)
  val velocity        = UInt(8.W)

  def withEndianSwapped() : GeneratorUpdate = {
    val w = Wire(new GeneratorUpdate)
    w.unused        := unused
    w.reset_note    := reset_note
    w.unused2       := unused2
    w.enabled       := enabled
    w.instrument    := swapEndian(instrument)
    w.note_index    := note_index
    w.channel_index := channel_index
    w.velocity      := velocity
    return w
  }
}

