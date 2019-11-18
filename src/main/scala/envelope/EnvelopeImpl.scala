package envelope

import chisel3.experimental.MultiIOModule
import chisel3._
import sadie.communication.Envelope
import sadie.config.config

class EnvelopeImpl extends MultiIOModule{

  val io = IO(
    new Bundle {
      val note_life = Input(UInt())
      val envelope = Input(new Envelope())
      val last_active_envelope_effect = Input(UInt())
      val enabled = Input(Bool())

      val envelope_effect = Output(UInt())
    }
  )

  /*
  Here is the envelope implementation. It is taken pretty directly from the reference implementation
   */
  val envelope = io.envelope
  val life = Wire(UInt(32.W))
  val scaled_sustain = Wire(UInt(16.W))

  life := io.note_life / config.NOTE_LIFE_COEFF.U
  scaled_sustain := (envelope.sustain << 8).asUInt() | envelope.sustain

  when(!io.enabled) {
    when (life < envelope.release) {
      io.envelope_effect := io.last_active_envelope_effect * (envelope.release - life) / envelope.release
    }.otherwise{
      io.envelope_effect := 0.U
    }
  }.elsewhen(life < envelope.attack) {
    io.envelope_effect := 0xffff.U * life / envelope.attack
  }.elsewhen(life < envelope.attack + envelope.decay) {
    io.envelope_effect := (envelope.decay - (life - envelope.attack)) * (0xffff.U - scaled_sustain) / envelope.decay + scaled_sustain
  }.otherwise{
    io.envelope_effect := scaled_sustain
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
