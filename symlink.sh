#!/bin/sh

# Remove icons and themes from DIRS since they're handled separately
DIRS="wallpapers wallpapers-live lockscreen avatars color-palettes"
TARGET="$HOME/Pictures"

# Handle icons separately
ln -snf $HOME/assets/icons/dunst $HOME/.local/share/icons/dunst

# Handle themes separately
mkdir -p ~/.themes
for theme in ~/assets/themes/*; do
    if [ -d "$theme" ]; then
        ln -snf "$theme" ~/.themes/
    fi
done

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
