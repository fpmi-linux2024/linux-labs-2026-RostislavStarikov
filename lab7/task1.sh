#!/bin/bash

cleanup(){
	echo "Скрипт остановлен"
	exit 0
}

trap cleanup SIGTSTP SIGINT SIGTERM

count=0
while true; do
	echo "Счётчик: $count"
	sleep 2 &
	wait $!
	count=$((count+1))

	if [ "$count" -eq 5 ]; then
		echo  "Сброс счётчика"
		count=0
	fi
done
