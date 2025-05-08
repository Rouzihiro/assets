#!/bin/sh

# List of directories to link
DIRS="wallpapers wallpapers-live lockscreen icons avatars"

# Target base directory
TARGET="$HOME/Pictures"

# Ensure the target directory exists
mkdir -p "$TARGET"

# Create symlinks
for dir in $DIRS; do
    if [ -d "./$dir" ]; then
        ln -sf "$(realpath "./$dir")" "$TARGET/$dir"
        echo "Linked $dir → $TARGET/$dir"
    else
        echo "Directory ./$dir not found, skipping."
    fi
done

