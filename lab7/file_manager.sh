#!/bin/bash
echo "Выберите действие: 1) Удалить файл, 2) переименовать файл, 3) переместить файл, 4) создать файл"
read choise

case $choise in
	1)
		read -p "Enter name file to delete: " file
		if [ -f "$file" ]; then
			rm -i "$file"
		else
			echo "$0: error: file $file not founded" >&2
		fi
		;;
	2)
		read -p "Enter current file name: " old
		read -p "Enter new file name: " new
		if [ -f "$old" ]; then
			mv "$old" "$new"
		else
			echo "$0: error: file $file not founded" >&2
		fi
		;;
	3)
		read -p "Enter file name: " file
		read -p "Enter destination directory" dir
		if [ -f "$file" ] && [ -d "$dir" ]; then
			mv "$file" "$dir/"
		else
			echo "$0: error: file or directory is not founded" >&2
		fi
		;;
	4)
		read -p "Enter file name: " file
		touch "$file"
		echo "File $file is created"
		;;
	*)
		echo "$0: error: bad request: $choise" >&2
		;;
esac
