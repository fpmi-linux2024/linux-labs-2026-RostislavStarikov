#!/bin/bash
output_file="test_data.txt"
> "$output_file"
words=("apple" "banana" "cherry" "dog" "elephant" "flower" "green" "house" "ice" "jungle" "kite" "lion" "mountain" "night" "ocean")

for i in {1..15}; do
    for j in {1..7}; do
        if (( j % 2 == 1 )); then
            printf "%s" "${words[$RANDOM % ${#words[@]}]}"
        else
            printf "%d" $((RANDOM % 1000 + 1))
        fi
        if (( j < 7 )); then
            printf " "
        fi
    done
    printf "\n"
done > "$output_file"
