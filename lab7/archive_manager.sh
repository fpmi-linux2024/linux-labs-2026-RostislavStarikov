#!/bin/bash

echo "Select an action:"
echo "1 - Archive"
echo "2 - Unzip"
read action

case $action in
    1)
read -p "Enter the archive directory: " dir
        read -p "Enter the archive name: " archive
        
        if [ -z "$dir" ] || [ -z "$archive" ]; then
            echo "$0: error: the directory and archive name cannot be empty" >&2
            exit 1
        fi
        
        if [ -d "$dir" ]; then
            tar -czf "$archive.tar.gz" "$dir"
            if [ $? -eq 0 ]; then
                echo "Archive $archive.tar.gz created by "
else
                echo "$0: error: failed to create archive" >&2
                exit 1
            fi
        else
echo "$0: error: directory $dir does not exist" >&2
            exit 1
        fi
        ;;
    2)
read -p "Enter the archive name: " archive
        
        if [ -z "$archive" ]; then
            echo "$0: error: archive name cannot be empty" >&2
            exit 1
        fi
        
        if [ -f "$archive.tar.gz" ]; then
            tar -xzf "$archive.tar.gz"
            if [ $? -eq 0 ]; then
                echo "Archive unpacked"
else
                echo "$0: error: couldn't extract archive" >&2
                exit 1
            fi
        else
echo "$0: error: archive $archive.tar.gz not found" >&2
            exit 1
        fi
        ;;
    *)
echo "$0: error: wrong choice" >&2
        exit 1
        ;;
esac