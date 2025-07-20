#!/bin/bash

echo "=== File Finder Tool ==="
read -p "Enter the starting directory (e.g., /home/yourname): " start_dir
read -p "Enter the file name or pattern to search for (e.g., *.sh or myfile.txt): " pattern

# Validate directory
if [ ! -d "$start_dir" ]; then
    echo "'$start_dir' is not a valid directory."
    exit 1
fi

# Run find command
echo "Searching for '$pattern' under '$start_dir'..."
find "$start_dir" -type f -name "$pattern"

