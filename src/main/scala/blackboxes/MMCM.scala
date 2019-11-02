// We shouldn't need this anymore. Kept for posterity.
package sadie.blackboxes

import chisel3._
import chisel3.core.IntParam
import chisel3.experimental.MultiIOModule
import chisel3.experimental.ExtModule

class MMCM extends MultiIOModule {
  val io = IO(new Bundle{
    val clk_in = Input(Clock())
    val clk_out1 = Output(Clock())
  })

  val mmcm = Module(new MMCM_clk_wiz())
  mmcm.clk_in := io.clk_in
  io.clk_out1 := mmcm.clk_out1
}

// Blackbox for verilog module, along with its shitty names
class MMCM_clk_wiz extends ExtModule() { // Verilog parameters
  override def desiredName: String = "MMCM_clk_wiz" // verilog name
  val clk_in = IO(Input(Clock()))
  val clk_out1 = IO(Output(Clock()))
}
