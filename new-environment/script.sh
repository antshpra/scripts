#!/bin/bash

# File containing the list of files to copy (one file per line)
file_list="file_list.txt"

# Source directory where the files are located
src_dir="/Users/prashant/workspace/azure-repos/DIF-SO-data-governance/CH-SO-BIA-DATAHUB-PL-EU-Dev"

# Destination directory where the files should be copied
dest_dir="/Users/prashant/workspace/azure-repos/DIF-SO-data-governance/CH-SO-BIA-DATAHUB-PL-EU-Dev"

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
while IFS= read -r line; do

    # Trim leading/trailing whitespace and ignore empty lines or lines starting with '#'
    line=$(echo "$line" | xargs)
    if [[ -z "$line" || "$line" == \#* ]]; then
        continue
    fi

    # Split the line into an array by treating multiple spaces as a single delimiter
    read -a files <<< "$line"
    
    src_file="${files[0]}"
    dest_file="${files[1]}"

    # Check if the file exists in the source directory
    if [[ -f "$src_dir/$src_file" ]]; then
        if [[ -f "$dest_dir/$dest_file" ]]; then
            echo "File already exists"
        else
            # Copy the file to the destination directory with the new name
            cp "$src_dir/$src_file" "$dest_dir/$dest_file"
            echo "Copied $src_file to $dest_dir as $dest_file"
        fi
    else
        echo "File $src_file not found in $src_dir"
    fi
done < "$file_list"

echo "File copying process completed."
