package sadie.blackboxes

import chisel3.util._
import chisel3._
import chisel3.core.IntParam
import chisel3.experimental.MultiIOModule
import chisel3.experimental.ExtModule

class I2SBus extends Bundle{
  val lrck = Output(Bool())  
  val bclk = Output(Bool()) 
  val data = Output(Bool())
}

// wrapper around verilog module
class I2S extends MultiIOModule {
  val io = IO(new Bundle{
    val resetn = Input(Bool())  
    val MCLK_in = Input(Clock())
    val wave_left_in = Input(UInt(24.W)) 
    val wave_right_in = Input(UInt(24.W))
    // i2s Interface
    val i2s           = new I2SBus
  })

  val i2s = Module(new i2s_sender())
  i2s.MCLK_in := io.MCLK_in
  i2s.resetn := io.resetn
  i2s.wave_left_in := io.wave_left_in
  i2s.wave_right_in := io.wave_right_in
  io.i2s.lrck := i2s.LRCK_out
  // SCLK is the bit clock. I2S is not a pretty format. I abstracted it away, ok.
  io.i2s.bclk := i2s.SCLK_out
  io.i2s.data := i2s.SDIN_out
}

// Blackbox for verilog module, along with its shitty names
class i2s_sender extends ExtModule {
  override def desiredName: String = "i2s_sender" // verilog name

  val resetn = IO(Input(Bool()))  
  val MCLK_in = IO(Input(Clock())) 
  val wave_left_in = IO(Input(UInt(24.W))) 
  val wave_right_in = IO(Input(UInt(24.W)))
  val LRCK_out = IO(Output(Bool())) 
  val SCLK_out = IO(Output(Bool()))
  val SDIN_out = IO(Output(Bool()))
}
