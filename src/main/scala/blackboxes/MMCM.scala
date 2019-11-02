// We shouldn't need this anymore. Kept for posterity.
package sadie.blackboxes

import chisel3._
import chisel3.core.{DoubleParam, IntParam, StringParam}
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

case class ClockConfig(divide: Int, duty_cycle: Double, phase: Double)

object ClockConfig {
  def default = ClockConfig(1, 0.5, 0.0)
}

class MMCME2(
              period: Double,
              base_mult: Double,
              base_div: Int,
              clock0_divide: Double,
              clocks: List[ClockConfig],
              clock4_cascade: Boolean
            ) extends ExtModule(Map(
  "CLKIN1_PERIOD"      -> DoubleParam(period),
  "CLKFBOUT_MULT_F"    -> DoubleParam(base_mult),
  "DIVCLK_DIVIDE"      -> IntParam(base_div),
  "CLKOUT4_CASCADE"    -> StringParam(if (clock4_cascade) "TRUE" else "FALSE"),
  "CLKOUT0_DIVIDE_F"   -> DoubleParam(clocks(0).divide),
  "CLKOUT0_DUTY_CYCLE" -> DoubleParam(clocks(0).duty_cycle),
  "CLKOUT0_PHASE"      -> DoubleParam(clocks(0).phase),
  "CLKOUT1_DIVIDE"     -> IntParam(clocks(1).divide),
  "CLKOUT1_DUTY_CYCLE" -> DoubleParam(clocks(1).duty_cycle),
  "CLKOUT1_PHASE"      -> DoubleParam(clocks(1).phase),
  "CLKOUT2_DIVIDE"     -> IntParam(clocks(2).divide),
  "CLKOUT2_DUTY_CYCLE" -> DoubleParam(clocks(2).duty_cycle),
  "CLKOUT2_PHASE"      -> DoubleParam(clocks(2).phase),
  "CLKOUT3_DIVIDE"     -> IntParam(clocks(3).divide),
  "CLKOUT3_DUTY_CYCLE" -> DoubleParam(clocks(3).duty_cycle),
  "CLKOUT3_PHASE"      -> DoubleParam(clocks(3).phase),
  "CLKOUT4_DIVIDE"     -> IntParam(clocks(4).divide),
  "CLKOUT4_DUTY_CYCLE" -> DoubleParam(clocks(4).duty_cycle),
  "CLKOUT4_PHASE"      -> DoubleParam(clocks(4).phase),
  "CLKOUT5_DIVIDE"     -> IntParam(clocks(5).divide),
  "CLKOUT5_DUTY_CYCLE" -> DoubleParam(clocks(5).duty_cycle),
  "CLKOUT5_PHASE"      -> DoubleParam(clocks(5).phase),
  "CLKOUT6_DIVIDE"     -> IntParam(clocks(6).divide),
  "CLKOUT6_DUTY_CYCLE" -> DoubleParam(clocks(6).duty_cycle),
  "CLKOUT6_PHASE"      -> DoubleParam(clocks(6).phase)
)) {
  // The name in the verilog file
  override def desiredName: String = "MMCME2_BASE"

  val CLKIN1    = IO(Input(Clock()))//This is ClockInputs
  val RST       = IO(Input(Bool())) // Reset is logic low
  val PWRDWN    = IO(Input(Bool()))
  val CLKFBIN   = IO(Input(Clock())) //Feedback In
  val CLKFBOUT  = IO(Output(Clock())) //Feedback Out
  val CLKFBOUTB = IO(Output(Clock()))
  val LOCKED    = IO(Output(Bool())) //wtf is this - status ports? - yes status port
  val CLKOUT0   = IO(Output(Clock()))
  val CLKOUT0B  = IO(Output(Clock()))
  val CLKOUT1   = IO(Output(Clock()))
  val CLKOUT1B  = IO(Output(Clock()))
  val CLKOUT2   = IO(Output(Clock()))
  val CLKOUT2B  = IO(Output(Clock()))
  val CLKOUT3   = IO(Output(Clock()))
  val CLKOUT3B  = IO(Output(Clock()))
  val CLKOUT4   = IO(Output(Clock()))
  val CLKOUT5   = IO(Output(Clock()))
  val CLKOUT6   = IO(Output(Clock()))
}


