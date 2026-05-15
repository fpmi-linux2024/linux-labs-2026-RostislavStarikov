#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Использование: $0 <dir> <каталог2>" >&2
    exit 1
fi

DIR1="$1"
DIR2="$2"
COUNT=0

if [ ! -d "$DIR1" ]; then
    echo "$0: ошибка: каталог $DIR1 не существует" >&2
    exit 1
fi

if [ ! -d "$DIR2" ]; then
    echo "$0: ошибка: каталог $DIR2 не существует" >&2
    exit 1
fi

for file1 in "$DIR1"/*; do
    if [ -f "$file1" ]; then
        COUNT=$((COUNT + 1))
        filename=$(basename "$file1")
        file2="$DIR2/$filename"
        if [ -f "$file2" ]; then
            if cmp -s "$file1" "$file2"; then
                echo "Одинаковые файлы: $filename"
            fi
        fi
    fi
done

echo "Просмотрено файлов: $COUNT"