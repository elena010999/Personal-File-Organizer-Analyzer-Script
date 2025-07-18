#!/bin/bash

while true; do
    clear
    read -p "Enter the path of the file to manage: " file_path
    echo "You've selected $file_path. Please specify the operation you want to perform:"
    echo "1) Move file"
    echo "2) Rename file"
    echo "3) Delete file"
    echo "4) Exit"

    read -p "Enter your choice [1-4]: " choice

    case "$choice" in
        1)
            echo "You chose to move the file."
            read -p "Please enter the folder path where you want to move file: " move_file_folder
	    mv "$file_path" "$move_file_folder"
	    echo "File was successfuly moved"
            ;;
        2)
            echo "You chose to rename the file."
            read -p "Please provide new name: " new_name
	    mv "$file_path" "$new_name"
	    echo "File was sucessfuly renamed"
            ;;
        3)
            echo "You chose to delete the file."
 	    rm "$file_path"
	    echo "File was successfuly removed"
            ;;
        4)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid choice. Please select 1-4."
            ;;
    esac

    echo
    read -p "Press Enter to continue..."
done

