#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Ошибка: нужно 2 аргумента"
    exit 1
fi
f="$1"
col="$2"
[ ! -f "$f" ] && echo "Файл не найден" && exit 1
[[ ! "$col" =~ ^[0-9]+$ ]] && echo "Колонка должна быть числом" && exit 1
mod="${f%.*}_modified.${f##*.}"
[ "$mod" = "$f" ] && mod="${f}_modified"
sed -E 's/[A-Za-z]+/0/g' "$f" > "$mod"
max=$(awk '{print NF}' "$mod" | head -1)
[ "$col" -gt "$max" ] && echo "Максимум $max колонок" && exit 1
sum=$(awk -v c="$col" '{s+=$c}END{print s}' "$mod")
cnt=$(awk -v c="$col" '{if($c!="")cnt++}END{print cnt}' "$mod")
[ "$cnt" -eq 0 ] && echo "Нет чисел в колонке $col" && exit 1
avg=$(echo "scale=2;$sum/$cnt" | bc)
echo "Исходный: $f"
echo "Изменённый: $mod"
echo "Колонка: $col"
echo "Среднее: $avg"
echo "Сумма: $sum"
