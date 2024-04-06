#!/bin/bash

# Define the directory where you want to remove Android special characters
directory="$HOME"

# Define Android special characters
android_special_chars="[:;*?\"<>|]"

# Iterate through all files and folders in the directory
find "$directory" -depth -name "*$android_special_chars*" | while IFS= read -r file; do
    # Remove Android special characters from file/folder names
    new_file=$(echo "$file" | sed "s/$android_special_chars//g")
    
    # Check if the new file name is different from the old one
    if [ "$file" != "$new_file" ]; then
        # Rename the file/folder
        mv "$file" "$new_file"
        echo "Renamed: $file -> $new_file"
    fi
done

echo "All Android special characters removed."

# Note: Sometimes nested folders will not rename properly. 
