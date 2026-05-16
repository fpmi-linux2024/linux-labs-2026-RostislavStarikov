#!/bin/bash
iface=$1
if [ -z "$iface" ]; then
    echo "Use: $0 name_of_interface"
    exit 1
fi
if ! ip link show "$iface" &> /dev/null; then
    echo "Interface $iface not founded"
    exit 1
fi
TYPE=$(nmcli -t -f TYPE device show "$iface" 2>/dev/null | cut -d: -f2)

if [ -n "$TYPE" ]; then
    echo "$TYPE"
else
    if [ -d "/sys/class/net/$iface/bridge" ]; then
        echo "bridge"
    elif [ -d "/sys/class/net/$iface/device" ]; then
        echo "ethernet (phizical)"
    else
        echo "virtual"
    fi
fi
