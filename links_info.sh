#!/bin/bash

echo "=== Welcome to links info tool ==="
read -p "Please enter the file you want to check: " path

if [ ! -e "$path" ]; then
    echo "Invalid path. Please enter valid file path"
    exit 1
fi

# Check if path is a symbolic link
if [ -L "$path" ]; then
    echo "'$path' is a symbolic link."
    target=$(readlink -f "$path")
    echo "It points to: $target"
    
    # Also find hard links to the target file (if it exists)
    if [ -e "$target" ]; then
        inode=$(stat -c %i "$target")
        echo "Inode number of target file: $inode"
        echo "Hard links to the target file:"
        find / -xdev -inum "$inode"
    else
        echo "Target file does not exist."
    fi

# If not a symlink, treat as a regular file or directory
else
    inode=$(stat -c %i "$path")
    echo "Inode number of '$path': $inode"
    echo "Hard links to this file:"
    find / -xdev -inum "$inode"
fi


