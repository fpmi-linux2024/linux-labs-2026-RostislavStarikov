# Лабораторная работа №3: Файлы, ссылки и права доступа

---

## Файлы протоколов

| Упражнение | Файл протокола | Файл меток времени |
|------------|----------------|---------------------|
| 1 | `task1Starikov` | `timelog1Starikov` |
| 2 | `task2Starikov` | `timelog2Starikov` |
| 3 | `task3Starikov` | `timelog3Starikov` |
| 4 | `task4Starikov` | `timelog4Starikov` |
| 5 | `task5Starikov` | `timelog5Starikov` |
| 6 | `task6Starikov` | `timelog6Starikov` |
| 7 | `task7Starikov` | `timelog7Starikov` |
| 8 | — | `timelog8Starikov.txt` |

---

## Основные команды

### Упражнение 1. Создание и просмотр файлов

mkdir -p ~/linux-labs/lab3
touch request.txt
cat -n request.txt          # нумерация строк
head -7 request.txt         # первые 7 строк
tail -6 request.txt         # последние 6 строк
sort request.txt            # сортировка


### Упражнение 2. Просмотр каталогов

ls -ltr                     # по времени (старые первые)
ls -lai                     # с inode и скрытыми файлами


### Упражнение 3. Копирование и перемещение

cp file.txt workdir/
mv file.txt workdir/


### Упражнение 4. Ссылки

ln target link              # жёсткая ссылка
ln -s target link           # символическая ссылка


### Упражнение 5. Права доступа

chmod 755 file              # числовой формат
chmod u+rwx,g+rx,o+r file   # символьный формат
umask 007                   # установка маски
chmod g+s somedir           # SGID


### Упражнение 6. ACL

setfacl -m u:user:rw file
getfacl file
cp --preserve=all src dst


### Упражнение 7. Атрибуты

chattr +i file              # неизменяемый
lsattr file                 # просмотр


### Упражнение 8. Astra Linux (привилегии)

sudo adduser student
su - student
traceroute 8.8.8.8
setcap cap_net_raw+ep /usr/bin/traceroute


---

## Структура каталога

```
linux-labs/lab3/
├── task.Starikov # протоколы
├── timelog.Starikov # метки времени
└── workdir/ # рабочий каталог
├── big.txt
├── request.bak
└── request.txt
```

---

## Ссылки
- [Корневой README](../README.md)

