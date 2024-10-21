#!/bin/bash

# File containing the list of files to copy (one file per line)
file_list="file_list.txt"

# Source directory where the files are located
src_dir="/path/to/source/directory"

# Destination directory where the files should be copied
dest_dir="/path/to/destination/directory"

# Check if the file list exists
if [[ ! -f $file_list ]]; then
    echo "File list $file_list not found!"
    exit 1
fi

# Check if the source directory exists
if [[ ! -d $src_dir ]]; then
    echo "Source directory $src_dir not found!"
    exit 1
fi

# Check if the destination directory exists; if not, create it
if [[ ! -d $dest_dir ]]; then
    echo "Destination directory $dest_dir not found. Creating it..."
    mkdir -p "$dest_dir"
fi

# Read each file from the list and copy it to the destination directory
while IFS= read -r file; do
    # Check if the file exists in the source directory
    if [[ -f "$src_dir/$file" ]]; then
        cp "$src_dir/$file" "$dest_dir/"
        echo "Copied $file to $dest_dir"
    else
        echo "File $file not found in $src_dir"
    fi
done < "$file_list"

echo "File copying process completed."
