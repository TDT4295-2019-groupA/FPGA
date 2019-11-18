package sadie.toplevel

import chisel3._
import chisel3.experimental.MultiIOModule
import generator.MinimalGenerator
import sadie.common.Adder
import sadie.communication._
import sadie.config.config
import sadie.generator.Generator

class SoundTopLevel() extends MultiIOModule {
  val io = IO(
    new Bundle {
      val generator_update_packet_valid = Input(Bool()) // pulsed for one cycle
      val generator_update_packet       = Input(new GeneratorUpdatePacket)
      val global_update_packet_valid    = Input(Bool()) // pulsed for one cycle
      val global_update_packet          = Input(new GlobalUpdatePacket)
      val step_sample                   = Input(Bool()) // pulsed for one cycle
      val sample_out                    = Output(SInt(32.W)) // TODO: define when this is valid
      val sample_out_valid = Output(Bool())
    }
  )

  // global generator state
  val global_config = Reg(new GlobalUpdate)
  when (io.global_update_packet_valid) {
    global_config := io.global_update_packet.data
  }

  // initalize our sample adder
  val adder = Module(new Adder()).io
  adder.volume := global_config.volume
  io.sample_out := adder.sample_out
  io.sample_out_valid := true.B


  // init the generators, and hook outputs to the adder
  for (i <- 1 to config.N_GENERATORS) {
    val generator = if (config.MinimalMode) Module(new MinimalGenerator()).io else Module(new Generator()).io
    generator.generator_update_valid := false.B // overridden below
    generator.generator_update       := io.generator_update_packet.data
    generator.global_config          := global_config
    generator.step_sample            := io.step_sample
    generator.generator_num          := i.U

    adder.samples_in(i-1) := generator.sample_out
    //printf("sample gen%d: %d\n", (i-1).U, generator.sample_out)

    when(io.generator_update_packet.generator_index === (i-1).U) {
      generator.generator_update_valid := io.generator_update_packet_valid
    }
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
  })
  top.generator_update_packet_valid := io.generator_update_packet_valid
  top.generator_update_packet       := io.packet_data.asTypeOf(new GeneratorUpdatePacket).withEndianSwapped()
  top.global_update_packet_valid    := io.global_update_packet_valid
  top.global_update_packet          := io.packet_data.asTypeOf(new GlobalUpdatePacket).withEndianSwapped()
  top.step_sample                   := io.step_sample
  io.sample_out                     := top.sample_out
}
