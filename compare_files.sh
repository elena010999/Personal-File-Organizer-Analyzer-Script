#!/bin/bash

echo "Welcome to the File Comparison Tool!"

while true; do
    read -p "Enter the first file path: " first_file
    if [ ! -f "$first_file" ]; then
        echo "Error: '$first_file' does not exist or is not a regular file. Please try again."
        continue
    fi

    read -p "Enter the second file path: " second_file
    if [ ! -f "$second_file" ]; then
        echo "Error: '$second_file' does not exist or is not a regular file. Please try again."
        continue
    fi

    echo "Choose the comparison method:"
    echo "1) Compare byte by byte (cmp)"
    echo "2) Show differences (diff)"
    echo "3) Compare SHA256 hashes (sha256sum)"
    read -p "Enter your choice (1, 2, or 3): " comparison_command

    case $comparison_command in
        1)
            echo "Running 'cmp' on the files..."
            if cmp -s "$first_file" "$second_file"; then
                echo "Files are identical (cmp reports no differences)."
            else
                echo "Files differ according to cmp."
            fi
            ;;
        2)
            echo "Running 'diff' on the files..."
            diff "$first_file" "$second_file"
            if [ $? -eq 0 ]; then
                echo "No differences found."
            else
                echo "Above are the differences between the files."
            fi
            ;;
        3)
            echo "Calculating SHA256 hashes..."
            first_file_sha=$(sha256sum "$first_file" | awk '{print $1}')
            second_file_sha=$(sha256sum "$second_file" | awk '{print $1}')
            echo "SHA256 for '$first_file': $first_file_sha"
            echo "SHA256 for '$second_file': $second_file_sha"
            if [ "$first_file_sha" == "$second_file_sha" ]; then
                echo "Success: Files have identical SHA256 hashes."
            else
                echo "Notice: Files have different SHA256 hashes."
            fi
            ;;
        *)
            echo "Invalid choice. Please select 1, 2, or 3."
            continue
            ;;
    esac

done

