#!/bin/bash

# macOS optimized asset linker
ASSETS_DIR="$(pwd)"

# macOS uses different paths
TARGET="$HOME/Pictures"

echo "📁 Linking assets from: $ASSETS_DIR to macOS locations"

# Wallpapers - macOS can use them from ~/Pictures
for dir in wallpapers wallpapers-live lockscreen avatars; do
    if [ -d "./$dir" ]; then
        SRC="$(cd "./$dir" && pwd -P)"
        DEST="$TARGET/$dir"
        
        # Remove old symlink if it exists
        [ -L "$DEST" ] && rm "$DEST"
        
        # Create new symlink
        if [ ! -e "$DEST" ]; then
            ln -s "$SRC" "$DEST"
            echo "✅ Linked $dir → $DEST"
        else
            echo "⚠️ $DEST exists and is not a symlink. Skipping."
        fi
    else
        echo "❌ Directory ./$dir not found"
    fi
done

echo ""
echo "✅ Setup complete!"
echo ""
echo "📸 For wallpapers on macOS:"
echo "   System Settings → Desktop & Screen Saver → Photos → Choose Folder"
echo "   Select: $TARGET/wallpapers"