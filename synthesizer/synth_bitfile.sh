#!/usr/bin/env bash
if [ "$1" = "FAST" ]; then
	SLOW="#"
fi
if [ "$1" = "NO_EDIF" ]; then
	SV_MODE=""
	EDIF_MODE="#"
else
	SV_MODE="#"
	EDIF_MODE=""
fi

# read config
source config.sh
source common.sh

# run vivado to convert to a bitfile for our FPGA
TMP="$(mktemp)"
colorize tee "$TMP" <<- EOT

	# read shit
	read_xdc constraints-$XILINX_PART.xdc
	${EDIF_MODE}read_edif $TOP_MODULE.edif
	${SV_MODE}read_verilog $TOP_MODULE.sv
	${SV_MODE}synth_design -top $TOP_MODULE -part $XILINX_PART

	# Select the FPGA to target and denote which module is the top module
	${EDIF_MODE}set_msg_config -id "Vivado 12-1411" -new_severity ERROR
	${EDIF_MODE}link_design -part $XILINX_PART -top $TOP_MODULE
	${EDIF_MODE}if [expr {[get_msg_config -severity Error -count] > 0}] { error "ERROR: Errors encountered! Abort!" }

	# This will detect errors early
	${SLOW}set_property SEVERITY {Error} [get_drc_checks NSTD-1]
	${SLOW}set_property SEVERITY {Error} [get_drc_checks UCIO-1]
	${SLOW}report_drc -return_string
	${SLOW}if [expr {[get_msg_config -severity Error -count] > 0}] { error "ERROR: Errors encountered! Abort!" }

	# Optimizer: deduce a more optimal design
	${SLOW}opt_design

	# Placer: Physical placement of cells from netlist, minimizing total wire length and routing congestions
	place_design

	# Router: Create physical wiring for placed design
	route_design

	# debug shit
	report_utilization; report_timing

	# dump results
	write_bitstream -force $TOP_MODULE.bit

EOT

colorize $XILINX_TOP_DIR/bin/vivado -mode batch -source "$TMP"
RET=$?
rm "$TMP"
exit $RET
