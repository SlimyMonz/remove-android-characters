#!/bin/bash

# Check if a directory argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Define the directory from the first argument
directory="$1"

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Error: The directory '$directory' does not exist."
    exit 1
fi

# Define Android special characters
android_special_chars="[:;*?\"<>|]"

# First pass: rename files
find "$directory" -depth -name "*$android_special_chars*" | while IFS= read -r file; do
    new_file=$(echo "$file" | sed "s/$android_special_chars//g")
    if [ "$file" != "$new_file" ]; then
        mv "$file" "$new_file"
        echo "Renamed: $file -> $new_file"
    fi
done

# Second pass: rename directories
find "$directory" -depth -name "*$android_special_chars*" | while IFS= read -r dir; do
    new_dir=$(echo "$dir" | sed "s/$android_special_chars//g")
    if [ "$dir" != "$new_dir" ]; then
        mv "$dir" "$new_dir"
        echo "Renamed: $dir -> $new_dir"
    fi
done

echo "All Android special characters removed."
