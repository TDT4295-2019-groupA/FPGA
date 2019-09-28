#!/usr/bin/env bash
SV_MODE="#"
if [ "$1" = "FAST" ]; then
	PERHAPS_SKIP="#"
	shift
elif [ "$1" = "NO_EDIF" ]; then
	SV_MODE=""
	EDIF_MODE="#"
	shift
elif [ -z "$1" ]; then
	# 'make' sucks
	shift
fi

# read config
source config.sh
source common.sh

# run yosys to synthesize the verilog file into a netlist
TMP="$(mktemp)"
colorize tee "$TMP" <<- EOT
	# read shit
	read_verilog $TOP_MODULE.v
	$(
		find include/ -type f -name '*.v' |
		while read line; do
			echo read_verilog $line
		done
	)
	$(
		while ! test -z "$1"; do
			echo read_verilog $1
			shift
		done
	)

	# Compile to System Verilog
	${SV_MODE}hierarchy -top $TOP_MODULE
	${SV_MODE}proc; opt; techmap; opt
	${SV_MODE}write_verilog $TOP_MODULE.sv

	# Synthesize into netlist
	${EDIF_MODE}synth_xilinx -top $TOP_MODULE -edif $TOP_MODULE.edif -flatten

EOT

colorize yosys -s "$TMP"
RET=$?
rm "$TMP"
exit $RET
