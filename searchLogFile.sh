#!/bin/bash

#Take input of file_name from command line
# if no name in command line then ask from user

if [ $# -eq 1 ]; then
    root_dir="$1"
else
    read -p "Enter the root directory: " root_dir
fi

# checking if directory exists
# if this does not exist, then exit from the program

if [ ! -d "$root_dir" ]; then
    echo "Directory '$root_dir' does not exist, exiting....."
    exit 1
fi

# search function to find keyword
search_for_error(){
    local sub_dir="$1"
    log_files=$(find "$sub_dir" -maxdepth 1 -type f -name "*.log" -exec stat --format="%Y %n" {} \; | sort -n -r | cut -d' ' -f2-)
    recent_log_files=$(echo "$log_files" | head -n 3)

    for log_file in $recent_log_files; do
        echo "Seaching for 'error' in $log_file:"
        grep -A 5 -B 5 -i "error" "$log_file"
        echo "---------------------------------------------"
    done  
}

# searching in parent directory
search_for_error "$root_dir"

for sub_dir in "$root_dir"/*/; do
    search_for_error "$sub_dir"
done 
