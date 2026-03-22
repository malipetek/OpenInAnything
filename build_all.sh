#!/bin/bash

# Build script for all OpenIn apps
# Usage: ./build_all.sh [category]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$SCRIPT_DIR/build"
APPS_DIR="$SCRIPT_DIR/apps"

# Clean build directory
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Function to compile AppleScript to app
compile_app() {
    local script_file="$1"
    local app_name="$2"
    local category="$3"
    
    echo "Building $app_name..."
    
    local script_dir=$(dirname "$script_file")
    local script_name=$(basename "$script_file" .applescript)
    
    # Compile the AppleScript
    osacompile -o "$BUILD_DIR/$app_name.app" "$script_file"
    
    # Set icon if available
    if [ -f "$SCRIPT_DIR/icon.icns" ]; then
        cp "$SCRIPT_DIR/icon.icns" "$BUILD_DIR/$app_name.app/Contents/Resources/applet.icns"
    fi
    
    echo "✓ Built $app_name.app"
}

# Build all apps or specific category
if [ -n "$1" ]; then
    CATEGORY="$1"
    echo "Building $CATEGORY apps..."
    
    for script in "$APPS_DIR/$CATEGORY"/*.applescript; do
        if [ -f "$script" ]; then
            script_name=$(basename "$script" .applescript)
            app_name="Open in $(echo "$script_name" | sed 's/\b\w/\u&/g')"
            compile_app "$script" "$app_name" "$CATEGORY"
        fi
    done
else
    echo "Building all apps..."
    
    # Build all categories
    for category_dir in "$APPS_DIR"/*; do
        if [ -d "$category_dir" ]; then
            category=$(basename "$category_dir")
            echo ""
            echo "=== Building $category ==="
            
            for script in "$category_dir"/*.applescript; do
                if [ -f "$script" ]; then
                    script_name=$(basename "$script" .applescript)
                    app_name="Open in $(echo "$script_name" | sed 's/\b\w/\u&/g')"
                    compile_app "$script" "$app_name" "$category"
                fi
            done
        fi
    done
fi

echo ""
echo "Build complete! Apps are in: $BUILD_DIR"
echo ""
echo "To install apps:"
echo "  cp -R \"$BUILD_DIR\"/*.app /Applications/"
echo ""
echo "To add to Finder toolbar:"
echo "  1. Open /Applications in Finder"
echo "  2. Hold Command key and drag apps to toolbar"
