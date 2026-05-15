#!/bin/bash
count=0
for iface_path in /sys/class/net/*; do
    iface=$(basename "$iface_path")
    [ "$iface" = "lo" ] && continue

    altname=""
    if [ -f "$iface_path/ifalias" ] && [ -s "$iface_path/ifalias" ]; then
        altname=$(cat "$iface_path/ifalias")
    else
        altname=$(ip -o link show dev "$iface" 2>/dev/null | \
                  grep -o 'altname [^ ]*' | cut -d' ' -f2)
    fi

    [ -z "$altname" ] && altname="-"

    count=$((count + 1))
    echo "$count. $iface (alt: $altname)"
done