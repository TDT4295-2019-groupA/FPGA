package envelope

import chisel3.experimental.MultiIOModule
import chisel3._
import sadie.communication.Envelope
import sadie.config.config

class EnvelopeImpl extends MultiIOModule{

  val io = IO(
    new Bundle {
      val note_life                   = Input(UInt())
      val envelope                    = Input(new Envelope())
      val last_active_envelope_effect = Input(UInt(16.W))
      val enabled                     = Input(Bool())

      val envelope_effect = Output(UInt(16.W))
      val is_in_release   = Output(Bool())
    }
  )

  /*
  Here is the envelope implementation. It is taken pretty directly from the reference implementation
   */
  val envelope       = io.envelope
  val life           = Wire(UInt(32.W))
  val scaled_sustain = Wire(UInt(16.W))
  val envelope_effect_out = RegInit(UInt(16.W), 0xFFFF.U) // pipelining
  val is_in_release_out   = RegInit(Bool(), false.B) // pipelining
  io.envelope_effect := envelope_effect_out
  io.is_in_release  := is_in_release_out

  is_in_release_out := false.B
  life := io.note_life / config.NOTE_LIFE_COEFF.U
  scaled_sustain := (envelope.sustain << 8).asUInt() | envelope.sustain

  when(!io.enabled) {
    when (life < envelope.release) {
      envelope_effect_out := io.last_active_envelope_effect * (envelope.release - life) / envelope.release
      is_in_release_out := true.B
    }.otherwise{
      envelope_effect_out := 0.U
    }
  }.elsewhen(life < envelope.attack) {
    envelope_effect_out := 0xffff.U * life / envelope.attack
  }.elsewhen(life < envelope.attack + envelope.decay) {
    envelope_effect_out := (envelope.decay - (life - envelope.attack)) * (0xffff.U - scaled_sustain) / envelope.decay + scaled_sustain
  }.otherwise{
    envelope_effect_out := scaled_sustain
  }
/*
  printf("Envelope: Attack: %d, Decay: %d, Sustain: %d, Release: %d, Last: %d, Life: %d, Scaled: %d\n",
    envelope.attack,
    envelope.decay,
    envelope.sustain,
    envelope.release,
    io.last_active_envelope_effect,
    life,
    scaled_sustain)
 */

}
