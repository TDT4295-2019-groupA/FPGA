package sadie.toplevel

import chisel3._
import chisel3.util._
import chisel3.experimental.MultiIOModule
import sadie.common.Adder
import sadie.communication._
import sadie.config.config
import sadie.generator._

class SoundTopLevel() extends MultiIOModule {
  val io = IO(
    new Bundle {
      val generator_update_packet_valid = Input(Bool()) // pulsed for one cycle
      val generator_update_packet       = Input(new GeneratorUpdatePacket)
      val global_update_packet_valid    = Input(Bool()) // pulsed for one cycle
      val global_update_packet          = Input(new GlobalUpdatePacket)
      val step_sample                   = Input(Bool()) // pulsed for one cycle, preferred pulse only while sample_out_valid is high
      val sample_out                    = Output(SInt(32.W)) // TODO: define when this is valid
      val sample_out_valid              = Output(Bool())
    }
  )

  // global generator state
  val global_config = Reg(new GlobalUpdate)
  when (io.global_update_packet_valid) { // read when valid
    global_config := io.global_update_packet.data
  }

  // initalize our sample adder
/*
  val adder = Module(new Adder()).io
  adder.volume := global_config.volume
  io.sample_out := adder.sample_out
*/
  val sample_out = RegInit(SInt(32.W), 0.S)
  io.sample_out := ((sample_out / config.VELOCITY_MAX.S) * global_config.volume) << 4.U

  io.sample_out_valid := false.B
  val selected_gen = Counter(config.N_GENERATORS + 1)
  when (selected_gen.value === 0.U) {
    io.sample_out_valid := true.B
    when (io.step_sample) {
      sample_out := 0.S
      selected_gen.inc()
    }
  }

  // init the generators, and hook outputs to the adder
  val generator_sample_computer = Module(new GeneratorSampleComputer).io
  generator_sample_computer.state := 0.U.asTypeOf(new GeneratorStateBundle)
  generator_sample_computer.global_config := global_config
  //generator_sample_computer.generator_num := selected_gen.value

  for (i <- 1 to config.N_GENERATORS) {
    val generator_state_handler = Module(new GeneratorStateHandler).io
    generator_state_handler.generator_update_valid := false.B // overridden below
    generator_state_handler.envelope_effect_valid  := false.B // overridden below
    generator_state_handler.generator_update       := io.generator_update_packet.data
    generator_state_handler.global_config          := global_config
    generator_state_handler.step_sample            := io.step_sample
    generator_state_handler.envelope_effect        := generator_sample_computer.envelope_effect

    when(io.generator_update_packet.generator_index === (i-1).U) {
      generator_state_handler.generator_update_valid := io.generator_update_packet_valid
    }

    when(selected_gen.value === i.U) {
      generator_sample_computer.state := generator_state_handler.state
      generator_state_handler.envelope_effect_valid := true.B
    }
  }
  when (selected_gen.value != 0.U) {
    sample_out := sample_out + generator_sample_computer.sample_out
    selected_gen.inc()
  }

}

// we are unable to assign BigInts to Bundles in PeekPokeTester,
// therefore we made this wrapper and test that instead
// while at it, we let this one handle endianess like we do in Top normally
class SoundTopLevelPeekPokeWrapper extends Module {
  val top = Module(new SoundTopLevel).io
  val io = IO(new Bundle { // wrapper for SoundTopLevel, since
    val generator_update_packet_valid = Input(Bool())
    val global_update_packet_valid    = Input(Bool())
    val packet_data                   = Input(UInt(256.W))
    val step_sample                   = Input(Bool())
    val sample_out                    = Output(SInt(32.W))
    val sample_out_valid              = Output(Bool())
  })
  top.generator_update_packet_valid := io.generator_update_packet_valid
  top.generator_update_packet       := io.packet_data.asTypeOf(new GeneratorUpdatePacket).withEndianSwapped()
  top.global_update_packet_valid    := io.global_update_packet_valid
  top.global_update_packet          := io.packet_data.asTypeOf(new GlobalUpdatePacket).withEndianSwapped()
  top.step_sample                   := io.step_sample
  io.sample_out                     := top.sample_out
  io.sample_out_valid               := top.sample_out_valid
}
