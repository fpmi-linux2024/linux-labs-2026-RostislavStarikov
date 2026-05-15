#!/bin/bash
dir="$HOME/Photos"
mkdir -p "$dir"
fswebcam -r 640x480 "$dir/photo_$(date +%Y%m%d_%H%M%S).jpg"
