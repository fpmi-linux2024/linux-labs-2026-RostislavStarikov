#!/bin/bash
if [ $# -ne 1 ]; then
	echo "$0: используйте: $0 <каталог>" >&2
	exit 1
fi
dir="$1"
if [ ! -d "$dir" ]; then
	echo "$0: каталог $dir не найден" >&2
	exit 1
fi
if [ ! -r "$dir" ]; then
	echo "$0: нет доступа к каталогу $dir" >&2
	exit 1
fi
files=()
while IFS= read -r -d '' file
do
	files+=("$file")
	done < <(find "$dir" -type f -perm 0755 -print0 2> >(while read -r err; do echo "$0: $err" >&2; done))
echo "Файлы с правами 755:"
for file in "${files[@]}"
do
	echo "$file"
done
echo "Всего найдено: ${#files[@]}"
