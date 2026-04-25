## Файлы протоколов

| Упражнение | Файл протокола | Файл меток времени |
|------------|----------------|---------------------|
| zip/unzip (1) | `task1Starikov` | `imelog1Starikov` |
| gzip/gunzip (2) | `task2Starikov` | `imelog2Starikov` |
| tar (3) | `task3Starikov` | `timelog3Starikov` |
| tar + gzip (4) | `task4Starikov` | `timelog4Starikov` |
| Astra Linux (4) | `task4astraStarikov` | `timelog4astraStarikov` |
| xz (5) | `task5Starikov` | `timelog5Starikov` |
| rsync (6) | `task6Starikov` | `timelog6Starikov` |
| Задание 2 (7) | `task7Starikov` | `timelog7Starikov` |

---

## Основные команды

### Утилиты `zip` / `unzip`
```bash
zip -r archive dir/                # рекурсивное добавление каталога
zip -s 20m archive.zip file        # многотомный архив (тома по 20 МБ)
unzip -l archive.zip               # просмотр содержимого
unzip -t archive.zip               # проверка целостности
unzip archive.zip -d target/       # распаковка в каталог
zip -F archive.zip --out fixed.zip # восстановление многотомного архива
