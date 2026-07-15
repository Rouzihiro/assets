#!/usr/bin/env bash

set -e

FONT_DIR="$HOME/.local/share/fonts"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/fonts"

echo "==> Installing fonts"

# Check source directory
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: fonts directory not found: $SOURCE_DIR"
    exit 1
fi

# Create user font directory
mkdir -p "$FONT_DIR"

# Copy fonts
echo "==> Copying fonts to $FONT_DIR"
cp -rv "$SOURCE_DIR"/* "$FONT_DIR"/

# Refresh font cache
echo "==> Updating font cache"
fc-cache -fv

echo "==> Fonts installed successfully"

