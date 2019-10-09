
# denoting where Xilinx Vivado is installed:
if [ -d "/opt/Xilinx/Vivado" ]; then
	XILINX_TOP_DIR="$(ls -d /opt/Xilinx/Vivado/*/ | head -n 1)"
fi
if [ -d "/tools/Xilinx/Vivado" ]; then
	XILINX_TOP_DIR="$(ls -d /tools/Xilinx/Vivado/*/ | head -n 1)"
fi

#XILINX_DIR=$XILINX_TOP_DIR/ids_lite/ISE

function colorize {
	if [ -t 1 ]; then
		ESC=$(printf '\033')
		stdbuf -o0 $@ 2>&1 |
		sed -u "s/^INFO:/${ESC}[36m&${ESC}[0m/" |
		sed -u "s/^Info:/${ESC}[36m&${ESC}[0m/" |
		sed -u "s/^=== .* ===/${ESC}[36m&${ESC}[0m/" |
		sed -u "s/^=*\$/${ESC}[36m&${ESC}[0m/" |
		sed -u "s/^-*\$/${ESC}[36m&${ESC}[0m/" |
		sed -u "s/^WARNING:/${ESC}[33m&${ESC}[0m/" |
		sed -u "s/^Warning:/${ESC}[33m&${ESC}[0m/" |
		sed -u "s/^CRITICAL\ WARNING:/${ESC}[33;!m&${ESC}[0m/" |
		sed -u "s/^ERROR:/${ESC}[31;1m&${ESC}[0m/" |
		sed -u "s/^Error:/${ESC}[31;1m&${ESC}[0m/" |
		sed -u "s/^SUCCESS:/${ESC}[32;1m&${ESC}[0m/" |
		sed -u "s/^Success:/${ESC}[32;1m&${ESC}[0m/" |
		sed -u "s/^#.*/${ESC}[34;1m&${ESC}[0m/"

		( exit "${PIPESTATUS[0]}" )
	else
		$@
	fi
}


if [ -z "$XILINX_TOP_DIR" ]; then
	colorize echo ERROR: UNABLE TO LOCATE VIVADO!
	colorize echo INFO: Please install it or modify scripts/common.sh with its location
	exit 1
fi
