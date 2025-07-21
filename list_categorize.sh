#!/bin/bash

read -p "Enter directory name to search: " directory_name

found_dirs=$(find / -type d -name "$directory_name")

if [ -z "$found_dirs" ]; then
  echo "No directory named '$directory_name' found."
  exit 1
fi

count=$(echo "$found_dirs" | wc -l)

if [ "$count" -eq 1 ]; then
  selected_dir="$found_dirs"
  echo "Only one directory found: $selected_dir"
else
  echo "$count directories found. Please select one:"
  
  i=1
  # Print directories with numbers
  echo "$found_dirs" | while read -r line; do
    echo "$i) $line"
    i=$((i + 1))
  done
  
  # Ask user to select
  while true; do
    read -p "Enter number (1-$count): " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "$count" ]; then
      break
    else
      echo "Invalid input. Try again."
    fi
  done
  
  # Get the selected directory
  selected_dir=$(echo "$found_dirs" | sed -n "${choice}p")
  echo "You selected: $selected_dir"
fi

# You can now use $selected_dir for further actions
echo "Processing directory: $selected_dir"
directory_list=$(ls $selected_dir)
echo "List files from $selected_dir: $directory_list"

declare -A file_categories  # associative array

# List of categories
categories=("Text Files" "Directories" "Symlinks" "Images" "PDFs" "Zips" "Videos" "Audios" "Others")

# Loop through files
for file in "$selected_dir"/*; do
    [ -e "$file" ] || continue
    mime_type=$(file -b --mime-type "$file")

    case "$mime_type" in
        inode/directory) key="Directories" ;;
        inode/symlink)   key="Symlinks" ;;
        text/*)          key="Text Files" ;;
        image/*)         key="Images" ;;
        application/pdf) key="PDFs" ;;
        application/zip) key="Zips" ;;
        video/*)         key="Videos" ;;
        audio/*)         key="Audios" ;;
        *)               key="Others" ;;
    esac

    # Append file to the corresponding category string
    file_categories["$key"]+=$(basename "$file")$'\n'
done

# Print each category (only if it has files)
for category in "${categories[@]}"; do
    if [ -n "${file_categories[$category]}" ]; then
        echo "$category:"
        echo "${file_categories[$category]}" | sed 's/^/  - /'
        echo
    fi
done

