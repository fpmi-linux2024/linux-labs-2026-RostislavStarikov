#!/bin/bash
read -p "Enter file name: " filename
name="${filename%.*}"
ext="${filename##*.}"
echo "Name: $name"
echo "Extension: $ext"
