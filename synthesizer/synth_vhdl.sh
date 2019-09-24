#!/bin/sh
OUTPUT="$1"
TOP_MODULE="$2"
shift
shift
TMP="$(mktemp)"

if test -z "$1"; then
	echo No vhdl files supplied!
	exit 1
fi

function colorize {
	if [ -t 1 ]; then
		ESC=$(printf '\033')
		stdbuf -o0 $@ 2>&1 |
		sed -u "s/^INFO:/${ESC}[36m&${ESC}[0m/" |
		sed -u "s/^WARNING:/${ESC}[33m&${ESC}[0m/" |
		sed -u "s/^CRITICAL WARNING:/${ESC}[33;!m&${ESC}[0m/" |
		sed -u "s/^ERROR:/${ESC}[31;1m&${ESC}[0m/" |
		sed -u "s/^#.*/${ESC}[34;1m&${ESC}[0m/"
	else
		$@
	fi
}

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
