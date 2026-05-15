#!/bin/bash
for iface in $(ls /sys/class/net/); do
	if [ "$(cat /sys/class/net/$iface/operstate 2>/dev/null)" = "up" ]; then
		echo "$iface: UP"
	else
		echo "$iface: DOWN"
	fi
done
