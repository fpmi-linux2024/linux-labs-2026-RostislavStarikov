#!/bin/bash
for i in {1..10}; do
	suffix=$(mcookie | cut -c1-16)
	echo "Name file$i = \"file$i.$suffix\""
done
