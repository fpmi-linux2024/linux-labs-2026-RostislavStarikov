#!/bin/bash
for iface in $(ls /sys/class/net/); do
	echo "$iface"
done
