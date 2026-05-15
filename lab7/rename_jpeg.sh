#!/bin/bash
for file in *.jpeg; do
	[ -f "$file" ] && mv "$file" "new_$file"
done

