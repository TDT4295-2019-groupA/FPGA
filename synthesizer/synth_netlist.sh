#!/usr/bin/env bash
if [ "$1" = "FAST" ]; then
	PERHAPS_SKIP="#"
	shift
elif [ -z "$1" ]; then
	shift
fi

# read config
source config.sh
source common.sh

# run yosys to synthesize the verilog file into a netlist
TMP="$(mktemp)"
colorize tee "$TMP" <<- EOT
	# read shit
	read_verilog -noblackbox $TOP_MODULE.v
	$(
		find include/ -type f -name '*.v' |
		while read line; do
			echo read_verilog -noblackbox $line
		done
	)
	$(
		while ! test -z "$1"; do
			echo read_verilog -noblackbox $1
			shift
		done
	)

	# Synth to System Verilog ( if using synth_design in vivado instead )
	#hierarchy -top $TOP_MODULE
	#proc; opt; techmap; opt
	#write_verilog $TOP_MODULE.sv

	# Synthesize - convert into netlist
	synth_xilinx -top $TOP_MODULE -edif $TOP_MODULE.edif

EOT

colorize yosys -s "$TMP"
RET=$?
rm "$TMP"
exit $RET
