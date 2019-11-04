package sadie.blackboxes

import chisel3.util._
import chisel3._
import chisel3.core.IntParam
import chisel3.experimental.MultiIOModule
import chisel3.experimental.ExtModule
import chisel3.internal.firrtl.Width

class I2SBus extends Bundle{
  val sclk = Output(Clock())
  val lrck = Output(Bool())  
  val bclk = Output(Bool()) 
  val data = Output(Bool())
}

// wrapper around verilog module
class I2S(width: Width) extends MultiIOModule {
  val io = IO(new Bundle{
    val resetn = Input(Bool())  
    val MCLK_in = Input(Clock())
    val wave_left_in = Input(UInt(width)) 
    val wave_right_in = Input(UInt(width))
    // i2s Interface
    val i2s           = new I2SBus
  })

  val i2s_sender = Module(new i2s_sender(width))
  i2s_sender.MCLK_in := io.MCLK_in
  i2s_sender.resetn := io.resetn
  i2s_sender.wave_left_in := io.wave_left_in
  i2s_sender.wave_right_in := io.wave_right_in
  io.i2s.lrck := i2s_sender.LRCK_out
  // SCLK is the bit clock. I2S is not a pretty format. I abstracted it away, ok.
  io.i2s.bclk := i2s_sender.SCLK_out
  io.i2s.data := i2s_sender.SDIN_out
  io.i2s.sclk := io.MCLK_in
}

// Blackbox for verilog module, along with its shitty names
class i2s_sender(width: Width) extends ExtModule {
  override def desiredName: String = "i2s_sender" // verilog name

  val resetn = IO(Input(Bool()))  
  val MCLK_in = IO(Input(Clock())) 
  val wave_left_in = IO(Input(UInt(width))) 
  val wave_right_in = IO(Input(UInt(width)))
  val LRCK_out = IO(Output(Bool())) 
  val SCLK_out = IO(Output(Bool()))
  val SDIN_out = IO(Output(Bool()))
}
