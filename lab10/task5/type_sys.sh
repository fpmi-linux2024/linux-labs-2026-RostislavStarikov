#!/bin/bash
iface=$1
if [ -z "$iface" ]; then
	echo "Use: $0 name_of_interface"
	exit 1
fi
if [ ! -d "/sys/class/net/$iface" ]; then
	echo "Interface $iface not founded"
	exit 1
fi
if [ -d "/sys/class/net/$iface/tun_flags" ]; then
	echo "TUN/TAP"
	exit 1
elif [ -d "/sys/class/net/$iface/bridge" ]; then
	echo "bridge"
elif [ -d "/sys/class/net/$iface/device" ]; then
	echo "phizical (or virtual with device)"
else
	echo "other type"
fi
