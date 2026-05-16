#!/bin/bash
iface=$1
if [ -z "$iface" ]; then
	echo "Use $0 name_of_interface";
	exit 1
fi
if ip tuntap show | grep "$iface" | grep -q "tun"; then
	echo "TUN" 
elif ip tuntap show | grep "$iface" | grep -q "tap"; then
	echo "TAP"
else
	echo "not TUN ot TAP"
fi
