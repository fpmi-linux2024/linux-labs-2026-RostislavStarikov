#!/bin/bash
LOG_FILE="/var/log/syslog"
REPORT_FILE="services_report_$(date +%Y%m%d).txt"

if [ ! -f "$LOG_FILE" ]; then
    echo "$0: ошибка: файл $LOG_FILE не найден" >&2
    exit 1
fi

echo "=== Отчёт о работе сервисов ===" > "$REPORT_FILE"
echo "Дата: $(date)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "Запущенные сервисы:" >> "$REPORT_FILE"
grep "Started" "$LOG_FILE" | awk '{print $5}' | sort -u >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "Сервисы, завершившиеся с ошибкой:" >> "$REPORT_FILE"
grep -i "failed\|error" "$LOG_FILE" | awk '{print $5}' | sort -u >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "Время последнего запуска сервисов:" >> "$REPORT_FILE"
for service in $(grep "Started" "$LOG_FILE" | awk '{print $5}' | sort -u); do
    last_start=$(grep "Started $service" "$LOG_FILE" | tail -1 | cut -d' ' -f1-3)
    echo "$service: $last_start" >> "$REPORT_FILE"
done

echo "Отчёт сохранён в $REPORT_FILE"