#!/usr/bin/env bash
if [ "$1" = "FAST" ]; then
	PERHAPS_SKIP="#"
fi
set -ex # enable verbose output and exit-on-error

# read config
source config.sh

# run yosys to synthesize the verilog file into a netlist
yosys - <<- EOT

	# read shit
	read_verilog $TOP_MODULE.v

	# Synth to System Verilog (if using synth_design in vivado)
	#hierarchy -top $TOP_MODULE
	#proc; opt; techmap; opt
	#write_verilog $TOP_MODULE.sv

	# Synthesize - convert into netlist
	synth_xilinx -top $TOP_MODULE -edif $TOP_MODULE.edif

EOT


# run vivado to convert to a bitfile for our FPGA
$XILINX_TOP_DIR/bin/vivado -mode tcl <<- EOT

	# read shit
	read_xdc constraints-$XILINX_PART.xdc
	read_edif $TOP_MODULE.edif

	#read_verilog $TOP_MODULE.sv
	#synth_design -rtl -top $TOP_MODULE -part $XILINX_PART

	# Select the FPGA to target and denote which module is the top module
	link_design -part $XILINX_PART -top $TOP_MODULE

	# Optimizer: deduce a more optimal design
	${PERHAPS_SKIP}opt_design

	# Placer: Physical placement of cells from netlist, minimizing total wire length and routing congestions
	place_design

	# Router: Create physical wiring for placed design
	route_design

	# debug shit
	report_utilization; report_timing

	# dump results
	write_bitstream -force $TOP_MODULE.bit

EOT

# set proper return code
set +ex # disable verbosity
echo -ne '\e[32;1m'
tail vivado.log | grep "^write_bitstream completed successfully$" && (echo -ne '\e[m') || (
	echo -ne '\e[31;1m'
	echo 'write_bitstream failed!'
	echo -ne '\e[m'
	false
)
