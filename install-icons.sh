#!/bin/sh
# Script to extract and install Tela icon theme

set -e  # Exit on error

# Configuration
ASSETS_DIR=$(pwd)
ICON_ZIP="Tela-icon-theme-master.zip"
ICON_SOURCE="$ASSETS_DIR/icons/$ICON_ZIP"
TEMP_DIR=""

echo "=== Installing Tela Icon Theme ==="

# Check if the zip file exists
if [ ! -f "$ICON_SOURCE" ]; then
    echo "Error: Icon theme zip not found at: $ICON_SOURCE"
    echo "Please ensure $ICON_ZIP exists in your icons directory"
    exit 1
fi

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
echo "Created temporary directory: $TEMP_DIR"

# Function to clean up temporary directory
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        echo "Cleaning up temporary directory: $TEMP_DIR"
        rm -rf "$TEMP_DIR"
    fi
}

# Set trap to ensure cleanup happens even on script failure
trap cleanup EXIT

# Extract the zip file
echo "Extracting $ICON_ZIP..."
if ! unzip -q "$ICON_SOURCE" -d "$TEMP_DIR"; then
    echo "Error: Failed to extract $ICON_ZIP"
    exit 1
fi

# Find the extracted directory (should be Tela-icon-theme-master)
EXTRACTED_DIR="$TEMP_DIR/Tela-icon-theme-master"
if [ ! -d "$EXTRACTED_DIR" ]; then
    # Try to find the directory if it has a different name
    EXTRACTED_DIR=$(find "$TEMP_DIR" -maxdepth 1 -type d -name "*Tela*" | head -1)
    
    if [ -z "$EXTRACTED_DIR" ] || [ ! -d "$EXTRACTED_DIR" ]; then
        echo "Error: Could not find extracted Tela theme directory"
        exit 1
    fi
fi

echo "Found theme directory: $(basename "$EXTRACTED_DIR")"

# Check if install.sh exists
INSTALL_SCRIPT="$EXTRACTED_DIR/install.sh"
if [ ! -f "$INSTALL_SCRIPT" ]; then
    echo "Error: install.sh not found in the extracted directory"
    echo "Looking for install.sh in: $EXTRACTED_DIR"
    exit 1
fi

# Make install.sh executable
chmod +x "$INSTALL_SCRIPT"

# Run the install script with -a flag (install all colors)
echo "Running installation script..."
cd "$EXTRACTED_DIR"
if ! ./install.sh -a; then
    echo "Error: Installation script failed"
    exit 1
fi

echo ""
echo "✅ Tela icon theme installation complete!"
echo "The theme should now be available in your system."
