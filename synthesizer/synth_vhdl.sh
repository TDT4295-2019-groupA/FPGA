#!/usr/bin/env bash
OUTPUT="$1"
TOP_MODULE="$2"
shift
shift
TMP="$(mktemp)"

if test -z "$1"; then
	echo No vhdl files supplied!
	exit 1
fi

source include.sh

(
	while ! test -z "$1" ; do
		echo read_vhdl "$1"
		shift
	done
	echo synth_design -top $TOP_MODULE
	echo write_verilog -force $OUTPUT
) | tee "$TMP"

colorize $XILINX_TOP_DIR/bin/vivado -mode batch -source "$TMP"

rm "$TMP"
rm *.jou *.log
