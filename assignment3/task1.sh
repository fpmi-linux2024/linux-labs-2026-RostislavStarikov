#!/bin/bash

# Функция, в которой SIGINT игнорируется
temporary_ignore_int() {
    # Сохраняем текущую обработку SIGINT
    local old_trap=$(trap -p SIGINT)
    # Устанавливаем игнорирование (пустая команда)
    trap '' SIGINT
    echo "Теперь SIGINT игнорируется. Попробуйте нажать Ctrl+C."
    sleep 5
    echo "Игнорирование закончено."
    # Восстанавливаем старую обработку
    eval "$old_trap"
}

echo "Основная часть: Ctrl+C прервёт сценарий."
sleep 2

temporary_ignore_int

echo "Обработка восстановлена. Ctrl+C снова прервёт."
sleep 2
echo "Сценарий завершён."
