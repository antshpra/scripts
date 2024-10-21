#!/bin/bash

# File containing the list of files to copy (one file per line)
file_list="files.txt"

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
while IFS= read -r file; do
    # Check if the file exists in the source directory
    if [[ -f "$src_dir/$file" ]]; then
        # Modify the destination file name by replacing _US_ with _DK_
        new_file=$(echo "$file" | sed 's/_US/_DK/g')

        # Copy the file to the destination directory with the new name
        cp "$src_dir/$file" "$dest_dir/$new_file"
        echo "Copied $file to $dest_dir as $new_file"
    else
        echo "File $file not found in $src_dir"
    fi
done < "$file_list"

echo "File copying process completed."
