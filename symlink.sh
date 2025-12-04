#!/bin/sh

# Script to symlink asset directories to target locations

set -e  # Exit on error

# Configuration
ASSETS_DIR=$(pwd)
DIRS="wallpapers wallpapers-live lockscreen avatars color-palettes"
TARGET="$HOME/Pictures"

echo "Linking assets from: $ASSETS_DIR"
echo ""

# Handle icons separately
echo "=== Setting up icons ==="
ICONS_TARGET="$HOME/.local/share/icons"
mkdir -p "$ICONS_TARGET"
ICONS_SRC="$ASSETS_DIR/icons/dunst"
if [ -d "$ICONS_SRC" ]; then
    if [ -L "$ICONS_TARGET/dunst" ]; then
        CURRENT_TARGET="$(readlink "$ICONS_TARGET/dunst")"
        if [ "$CURRENT_TARGET" = "$ICONS_SRC" ]; then
            echo "Icon link already exists: $ICONS_TARGET/dunst → $ICONS_SRC"
        else
            echo "Updating icon link: $ICONS_TARGET/dunst → $ICONS_SRC"
            ln -sf "$ICONS_SRC" "$ICONS_TARGET/"
        fi
    elif [ -e "$ICONS_TARGET/dunst" ]; then
        echo "Warning: $ICONS_TARGET/dunst exists and is not a symlink. Skipping."
    else
        echo "Creating icon link: $ICONS_TARGET/dunst → $ICONS_SRC"
        ln -s "$ICONS_SRC" "$ICONS_TARGET/"
    fi
else
    echo "Warning: Icons directory not found: $ICONS_SRC"
fi
echo ""

# Handle themes separately
echo "=== Setting up themes ==="
THEMES_TARGET="$HOME/.themes"
mkdir -p "$THEMES_TARGET"

if [ -d "$ASSETS_DIR/themes" ]; then
    for theme in "$ASSETS_DIR"/themes/*; do
        if [ ! -d "$theme" ]; then
            continue
        fi
        
        theme_name=$(basename "$theme")
        THEME_DEST="$THEMES_TARGET/$theme_name"
        
        if [ -L "$THEME_DEST" ]; then
            CURRENT_TARGET="$(readlink "$THEME_DEST")"
            if [ "$CURRENT_TARGET" = "$theme" ]; then
                echo "Theme link already exists: $THEME_DEST → $theme"
                continue
            else
                echo "Updating theme link: $THEME_DEST → $theme"
                ln -sf "$theme" "$THEME_DEST"
            fi
        elif [ -e "$THEME_DEST" ]; then
            echo "Warning: $THEME_DEST exists and is not a symlink. Skipping."
        else
            echo "Creating theme link: $THEME_DEST → $theme"
            ln -s "$theme" "$THEME_DEST"
        fi
    done
else
    echo "Warning: Themes directory not found: $ASSETS_DIR/themes"
fi
echo ""

# Handle other asset directories
echo "=== Setting up asset directories ==="
mkdir -p "$TARGET"

for dir in $DIRS; do
    SRC="$(realpath "./$dir")"
    DEST="$TARGET/$dir"

    if [ ! -d "./$dir" ]; then
        echo "Directory ./$dir not found, skipping."
        continue
    fi

    if [ -L "$DEST" ]; then
        CURRENT_TARGET="$(readlink "$DEST")"
        if [ "$CURRENT_TARGET" = "$SRC" ]; then
            echo "Link already exists: $DEST → $SRC"
            continue
        else
            echo "Updating link: $DEST → $SRC"
            ln -sf "$SRC" "$DEST"
        fi
    elif [ -e "$DEST" ]; then
        echo "Warning: $DEST exists and is not a symlink. Skipping."
    else
        ln -s "$SRC" "$DEST"
        echo "Linked $dir → $DEST"
    fi
done

echo ""
echo "Setup complete!"
