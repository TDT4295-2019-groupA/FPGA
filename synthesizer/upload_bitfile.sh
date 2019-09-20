#!/bin/bash
set -ex

# read config
source config.sh

if ! test -f "$TOP_MODULE.bit"; then
	echo "ERROR: No bitfile to upload!"
	exit 1
fi

# upload the bitfile to the FPGA

$XILINX_TOP_DIR/bin/vivado -mode tcl <<- EOT

	# start the hardware server
	open_hw

	# Connect to the Digilent Cable on localhost:3121
	connect_hw_server -url localhost:3121
	current_hw_target [get_hw_targets */xilinx_tcf/Digilent/210319A28ED8A]
	open_hw_target

	# Program and Refresh the xc7a35t_0 Device
	current_hw_device [lindex [get_hw_devices] 0]
	refresh_hw_device -update_hw_probes false [lindex [get_hw_devices] 0]
	set_property PROGRAM.FILE {$(pwd)/$TOP_MODULE.bit} [lindex [get_hw_devices] 0]
	# set_property PROBES.FILE {$(pwd)/$TOP_MODULE.ltx} [lindex [get_hw_devices] 0]

	program_hw_devices [lindex [get_hw_devices] 0]
	refresh_hw_device [lindex [get_hw_devices] 0]

EOT
