
function colorize {
	if [ -t 1 ]; then
		ESC=$(printf '\033')
		stdbuf -o0 $@ 2>&1 |
		sed -u "s/INFO:/${ESC}[36m&${ESC}[0m/" |
		sed -u "s/=== .* ===/${ESC}[36m&${ESC}[0m/" |
		sed -u "s/WARNING:/${ESC}[33m&${ESC}[0m/" |
		sed -u "s/CRITICAL WARNING:/${ESC}[33;!m&${ESC}[0m/" |
		sed -u "s/ERROR:/${ESC}[31;1m&${ESC}[0m/" |
		sed -u "s/^#.*/${ESC}[34;1m&${ESC}[0m/"

		( exit "${PIPESTATUS[0]}" )
	else
		$@
	fi
}
