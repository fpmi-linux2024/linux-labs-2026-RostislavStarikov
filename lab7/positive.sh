#!/bin/bash
read -p "Введите целое число: " num


if [ "$num" -gt 0 ] 2>/dev/null; then
	echo "Positive"
elif [ $num -eq 0 ] 2>/dev/null; then
	echo "Zero"
else
	echo "Negative"
fi
