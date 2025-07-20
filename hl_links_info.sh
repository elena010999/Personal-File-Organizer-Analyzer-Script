#!/bin/bash

echo "===Welcome to links info tool==="
read -p "Please enter the file you want to check: " path

if [ ! -e "$path" ]; then
	echo "Invalid path. Please enter valid file path"
	exit
fi

if [ -e "$path" ]; then
	inode=$(stat -c %i "$path")
fi

#Find all files with same inode number

echo "All the files with same inode number"
find ~/ -xdev -inum "$inode"



