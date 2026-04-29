#!/bin/bash

# Проверка количества аргументов
if [ $# -ne 2 ]; then
    echo "Использование: $0 <имя_пользователя> <каталог>"
    exit 1
fi

USERNAME=$1
TARGET_DIR=$2
TEMP_FILE="/tmp/user_list.txt"

# Проверка существования пользователя
if ! id "$USERNAME" &>/dev/null; then
    echo "Ошибка: пользователь '$USERNAME' не существует."
    exit 1
fi

# Проверка существования каталога
if [ ! -d "$TARGET_DIR" ]; then
    echo "Ошибка: каталог '$TARGET_DIR' не существует."
    exit 1
fi

# Функция поиска файлов пользователя
find_user_files() {
    find "$TARGET_DIR" -type f -user "$USERNAME" -print
}

# Функция архивации
archive_files() {
    local file_list=$(find_user_files)
    if [ -z "$file_list" ]; then
        echo "Нет файлов пользователя '$USERNAME' в каталоге '$TARGET_DIR'."
        exit 0
    fi
    # Создаём архив, переходя в каталог, чтобы пути были относительными
    cd "$TARGET_DIR"
    tar -czf "$OLDPWD/user_files.tar.gz" $file_list 2>/dev/null
    cd "$OLDPWD"
    local archive_path="$(pwd)/user_files.tar.gz"
    echo "Архив создан: $archive_path"
    echo "Размер архива: $(du -h "$archive_path" | cut -f1)"
}

# Обработчик SIGUSR1
handle_sigusr1() {
    echo "Получен сигнал SIGUSR1. Сохраняем список файлов в $TEMP_FILE"
    find_user_files > "$TEMP_FILE"
    echo "Список сохранён. Архивация не производится."
    exit 0
}

# Установка обработчика на SIGUSR1
trap handle_sigusr1 SIGUSR1

# Основная логика: архивация (если сигнал не пришёл)
archive_files
#!/bin/bash

# Проверка количества аргументов
if [ $# -ne 2 ]; then
    echo "Использование: $0 <имя_пользователя> <каталог>"
    exit 1
fi

USERNAME=$1
TARGET_DIR=$2
TEMP_FILE="/tmp/user_list.txt"

# Проверка существования пользователя
if ! id "$USERNAME" &>/dev/null; then
    echo "Ошибка: пользователь '$USERNAME' не существует."
    exit 1
fi

# Проверка существования каталога
if [ ! -d "$TARGET_DIR" ]; then
    echo "Ошибка: каталог '$TARGET_DIR' не существует."
    exit 1
fi

# Функция поиска файлов пользователя
find_user_files() {
    find "$TARGET_DIR" -type f -user "$USERNAME" -print
}

# Обработчик SIGUSR1
handle_sigusr1() {
    echo ""
    echo "Получен сигнал SIGUSR1. Сохраняем список файлов в $TEMP_FILE"
    find_user_files > "$TEMP_FILE"
    echo "Список сохранён. Архивация не производится."
    exit 0
}

# Функция архивации
archive_files() {
    local file_list=$(find_user_files)
    if [ -z "$file_list" ]; then
        echo "Нет файлов пользователя '$USERNAME' в каталоге '$TARGET_DIR'."
        exit 0
    fi
    
    echo "Найденные файлы:"
    echo "$file_list"
    echo ""
    echo "Архивация начнётся через 10 секунд."
    echo "Отправьте SIGUSR1 (kill -USR1 $$), чтобы сохранить список и выйти без архивации."
    
    # Обратный отсчёт
    for i in {10..1}; do
        echo -ne "Осталось $i секунд... \r"
        sleep 1
    done
    echo ""
    
    # Создаём архив
    cd "$TARGET_DIR"
    tar -czf "$OLDPWD/user_files.tar.gz" $file_list 2>/dev/null
    cd "$OLDPWD"
    
    local archive_path="$(pwd)/user_files.tar.gz"
    echo "Архив создан: $archive_path"
    echo "Размер архива: $(du -h "$archive_path" | cut -f1)"
}

# Установка обработчика на SIGUSR1
trap handle_sigusr1 SIGUSR1

# Вывод PID для удобства
echo "PID сценария: $$"

# Основная логика
archive_files
