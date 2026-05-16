#!/bin/bash
iface=$1
if [ -z "$iface" ]; then
	echo "Use: $0 name_of_interface"
	exit
fi

if ! ip link show "$iface" &> /dev/null; then
	echo "Interface $iface not founded"
	exit 1
fi

ip -d link show "$iface" | awk -v iface="$iface" '
/tun/ { print "TUN"; found=1 }
/tap/ { print "TAP"; found=1 }
/bridge/ { print "bridge"; found=1 }
END { if(!found) print "other type" }'
