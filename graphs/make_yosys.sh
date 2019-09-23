#!/usr/bin/env bash

VERILOG_FILE="$1"
test "$VERILOG_FILE" = "" && (
	echo please supple a .v verilog file
	exit 1
)

test -d yosys && rm -vr yosys
mkdir -p yosys

grep "^module" "$VERILOG_FILE" | cut -d" " -f2- | cut -d"(" -f1 | (
	echo "read_verilog $VERILOG_FILE"
	echo "prep"
	while read MODULE; do
		echo "show -format svg -colors 42 -stretch -prefix yosys/$MODULE $MODULE"
	done
) |  yosys -Q -T -
