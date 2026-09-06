#!/usr/bin/env bash

# macOS font installer - Simplified

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/fonts"
FONT_DIR="$HOME/Library/Fonts"

echo "==> Installing fonts on macOS"

# Check source
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: fonts directory not found"
    exit 1
fi

# Create destination
mkdir -p "$FONT_DIR"

# Copy all font files
echo "=> Copying fonts..."
find "$SOURCE_DIR" -type f \( -name "*.ttf" -o -name "*.otf" -o -name "*.ttc" -o -name "*.dfont" \) -exec cp -v {} "$FONT_DIR/" \;

# Remove quarantine
xattr -d com.apple.quarantine "$FONT_DIR"/*.{ttf,otf,ttc,dfont} 2>/dev/null || true

# Reset font cache
echo "=> Resetting font cache..."
atsutil databases -remove 2>/dev/null || true

echo "✅ Fonts installed to ~/Library/Fonts"
echo "   Restart applications to see new fonts"
