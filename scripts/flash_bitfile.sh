#!/bin/bash
source $(dirname $0)/common.sh

BITFILE="$1"; shift
MCS="$(dirname $BITFILE)/main.mcs"
PRM="$(dirname $BITFILE)/main.prm"
CFGMEM_PART="mt25qu128-spi-x1_x2_x4"
CFGMEM_PART="mt25ql128"
CFGMEM_PART="mt25ql128-spi-x1_x2_x4"

CFGMEM_PART="s25fl128sxxxxxx0-spi-x1_x2_x4"

if ! test -f "$BITFILE"; then
	echo "ERROR: No bitfile to flash!"
	exit 1
fi

# flash configuration chip

TMP="$(mktemp)"
colorize tee "$TMP" <<- EOT
	# write mcs file
	write_cfgmem -force -format mcs -interface spix4 -size 16 -loadbit "up 0x0 $BITFILE" -file "$MCS"

	# start the hardware server
	open_hw

	# connect to fpga
	connect_hw_server -url localhost:3121
	current_hw_target [get_hw_targets *]
	open_hw_target

	# get device, refresh
	current_hw_device [lindex [get_hw_devices *] 0]
	refresh_hw_device [lindex [get_hw_devices *] 0]

	# settings for configuration
	create_hw_cfgmem -hw_device [lindex [get_hw_devices] 0] [lindex [get_cfgmem_parts {$CFGMEM_PART}] 0]
	set_property PROGRAM.ADDRESS_RANGE {entire_device} [current_hw_cfgmem]
	set_property PROGRAM.FILES [list "$MCS"] [current_hw_cfgmem]
	set_property PROGRAM.PRM_FILE {$PRM} [current_hw_cfgmem]
	set_property PROGRAM.UNUSED_PIN_TERMINATION {pull-none} [current_hw_cfgmem]
	set_property PROGRAM.BLANK_CHECK 0 [current_hw_cfgmem]

	# can be 0 to speed up, i think
	set_property PROGRAM.ERASE 1 [current_hw_cfgmem]
	set_property PROGRAM.CFG_PROGRAM 1 [current_hw_cfgmem]

	# can be 0 to speed up, i think
	set_property PROGRAM.VERIFY 1 [current_hw_cfgmem]
	set_property PROGRAM.CHECKSUM 0 [current_hw_cfgmem]

	# flash configuration. this WILL take a while. be patient!
	startgroup
	create_hw_bitstream -hw_device [lindex [get_hw_devices] 0] [get_property PROGRAM.HW_CFGMEM_BITFILE [ lindex [get_hw_devices] 0]]; program_hw_devices [lindex [get_hw_devices] 0]; refresh_hw_device [lindex [get_hw_devices] 0];
	program_hw_cfgmem -hw_cfgmem [current_hw_cfgmem]
	endgroup

	# reboot. might not be necessary.
	boot_hw_device  [lindex [get_hw_devices] 0]
EOT

colorize $XILINX_TOP_DIR/bin/vivado -mode batch -source "$TMP"
RET=$?
rm "$TMP"
exit $RET
