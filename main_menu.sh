#!/bin/bash

while true; do
    clear
    echo "=== Smart File Toolkit ==="
    echo "1) List and categorize files by type"
    echo "2) Move, rename, or delete files interactively"
    echo "3) Search text inside .txt files"
    echo "4) Compare two files and show differences"
    echo "5) Compress a folder or file (ZIP/TAR.GZ)"
    echo "6) Show info about symbolic and hard links"
    echo "7) Find files by name or pattern"
    echo "8) View log file (last run output)"
    echo "9) Exit"
    echo
    read -p "Select an option [1-9]: " choice

    case "$choice" in
        1) ./list_categorize.sh ;;
        2) ./file_ops.sh ;;
        3) ./search_text.sh ;;
        4) ./compare_files.sh ;;
        5) ./compress.sh ;;
        6) ./links_info.sh ;;
        7) ./find_files.sh ;;
        8) less ./Logs/latest.log ;;  # Adjust log path as needed
        9) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option, please try again."; sleep 1 ;;
    esac

    echo
    read -p "Press Enter to return to menu..."
done

