// Some ideas here from gruppe B, thank you lots.
package sadie.blackboxes

import chisel3._
import chisel3.core.{IntParam, StringParam, DoubleParam}
import chisel3.experimental.MultiIOModule
import chisel3.experimental.ExtModule
// check this pdf out: https://www.xilinx.com/support/documentation/sw_manuals/xilinx2012_2/ug953-vivado-7series-libraries.pdf
// we use PLLE2_BASE since we dont need phase shift
// Blackbox for verilog primitive
// Fill in these numbers as needed. Currently clock 1 is 16MHz * 30/1 = 480MHz, clock 2 is 240, etc. 
class PLL extends ExtModule(Map("BANDWIDTH" -> StringParam("OPTIMIZED"),
                                "CLKFBOUT_MULT" -> IntParam(30),
                                "CLKFBOUT_PHASE" -> DoubleParam(0.0),
                                "CLKIN1_PERIOD" -> DoubleParam(62.500),
                                "CLKOUT0_DIVIDE" -> IntParam(1),
                                "CLKOUT1_DIVIDE" -> IntParam(2),
                                "CLKOUT2_DIVIDE" -> IntParam(3),
                                "CLKOUT3_DIVIDE" -> IntParam(4),
                                "CLKOUT4_DIVIDE" -> IntParam(5),
                                "CLKOUT5_DIVIDE" -> IntParam(6),
                                "CLKOUT0_DUTY_CYCLE" -> DoubleParam(0.5),
                                "CLKOUT1_DUTY_CYCLE" -> DoubleParam(0.5),
                                "CLKOUT2_DUTY_CYCLE" -> DoubleParam(0.5),
                                "CLKOUT3_DUTY_CYCLE" -> DoubleParam(0.5),
                                "CLKOUT4_DUTY_CYCLE" -> DoubleParam(0.5),
                                "CLKOUT5_DUTY_CYCLE" -> DoubleParam(0.5),
                                "CLKOUT0_PHASE" -> DoubleParam(0.0),
                                "CLKOUT1_PHASE" -> DoubleParam(0.0),
                                "CLKOUT2_PHASE" -> DoubleParam(0.0),
                                "CLKOUT3_PHASE" -> DoubleParam(0.0),
                                "CLKOUT4_PHASE" -> DoubleParam(0.0),
                                "CLKOUT5_PHASE" -> DoubleParam(0.0),
                                "DIVCLK_DIVIDE" -> IntParam(1),
                                //"REF_JITTER1" -> 0.010,
                                "STARTUP_WAIT" -> StringParam("FALSE")
)) { // Verilog parameters
  override def desiredName: String = "PLLE2_BASE" // verilog name
  val CLKIN1 = IO(Input(Clock()))
  val CLKOUT0 = IO(Output(Clock()))
  val CLKOUT1 = IO(Output(Clock()))
  val CLKOUT2 = IO(Output(Clock()))
  val CLKOUT3 = IO(Output(Clock()))
  val CLKOUT4 = IO(Output(Clock()))
  val CLKOUT5 = IO(Output(Clock()))
  val CLKFBIN = IO(Input(Clock()))
  val CLKFBOUT = IO(Output(Clock()))
  val LOCKED = IO(Output(Bool()))
  val PWRDWN = IO(Input(Bool()))
  val RST = IO(Input(Bool()))
}
