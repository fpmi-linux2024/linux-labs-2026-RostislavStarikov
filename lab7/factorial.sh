#!/bin/bash
read -p "Введите число: " n
fact=1
for ((i=1; i<=n; i++)); do
	fact=$((fact*i))
done
echo "$n ! = $fact"
