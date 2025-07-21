#!/bin/bash

echo "=== Welcome to Compression of File/Folder Tool ==="
read -p "Enter the path to the folder or file you want to compress: " path

# Check if path exists
if [ ! -e "$path" ]; then
    echo "Invalid path. Please enter a valid file or directory."
    exit 1
fi

# Get original size
original_size=$(du -sh "$path" | awk '{print $1}')

# If it's a file
if [ -f "$path" ]; then
    echo "File detected: $path"
    
    # Compress the file using gzip and keep the original
    gzip -k "$path"
    
    compressed_file="${path}.gz"
    compressed_size=$(du -sh "$compressed_file" | awk '{print $1}')
    
    echo "Compression completed!"
    echo "Original file: $path"
    echo "Compressed file: $compressed_file"
    echo "Original size: $original_size"
    echo "Compressed size: $compressed_size"

# If it's a directory
elif [ -d "$path" ]; then
    echo "Directory detected: $path"
    
    folder_name=$(basename "$path")
    output_file="${folder_name}_archive.tar.gz"
    
    tar -czf "$output_file" -C "$(dirname "$path")" "$folder_name"
    
    compressed_size=$(du -sh "$output_file" | awk '{print $1}')
    
    echo "Compression completed!"
    echo "Original folder: $path"
    echo "Compressed archive: $(realpath "$output_file")"
    echo "Original size: $original_size"
    echo "Compressed size: $compressed_size"

else
    echo "Unsupported file type."
    exit 1
fi



