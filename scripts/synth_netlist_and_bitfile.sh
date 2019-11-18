#!/usr/bin/env bash
source $(dirname $0)/common.sh
if [ "$1" = "FAST" ]; then
	SLOW="#"
	shift
fi
if [ -z "$1" ]; then
	# make sucks
	shift
fi

TOP_MODULE="$1";       shift
XILINX_PART="$1";      shift
CONSTRAINTS_FILE="$1"; shift
OUTPUT_PATH="$1";      shift


# run vivado to convert to a bitfile for our FPGA
TMP="$(mktemp)"
colorize tee "$TMP" <<- EOT

	# read shit
	read_xdc $CONSTRAINTS_FILE
	$(
		while ! test -z "$1"; do
			echo read_verilog $1
			shift
		done
	)

	# Synth the design
	synth_design -top $TOP_MODULE -part $XILINX_PART

	# This will detect errors early
	${SLOW}set_property SEVERITY {Error} [get_drc_checks NSTD-1]
	${SLOW}set_property SEVERITY {Error} [get_drc_checks UCIO-1]
	${SLOW}report_drc -return_string
	${SLOW}if [expr {[get_msg_config -severity Error -count] > 0}] { error "ERROR: Errors encountered! Abort!" }

	# Optimizer: deduce a more optimal design
	${SLOW}opt_design
	
	# make implemented design possible to SPI flash. must be done before implementation.
	set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [get_designs *]

	# Placer: Physical placement of cells from netlist, minimizing total wire length and routing congestions
	place_design

	# Router: Create physical wiring for placed design
	route_design

	# debug shit
	report_utilization; report_timing

	# dump results
	write_bitstream -force $OUTPUT_PATH

EOT

colorize $XILINX_TOP_DIR/bin/vivado -mode batch -source "$TMP"
RET=$?
rm "$TMP"
exit $RET
