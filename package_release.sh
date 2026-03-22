#!/bin/bash

# Package script for creating release zip files

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$SCRIPT_DIR/build"
RELEASE_DIR="$SCRIPT_DIR/release"
VERSION=${1:-"1.0.0"}

echo "Packaging OpenIn apps for release v$VERSION..."

# Clean and create release directory
rm -rf "$RELEASE_DIR"
mkdir -p "$RELEASE_DIR"

# Function to create a zip for a single app
package_app() {
    local app_path="$1"
    local app_name=$(basename "$app_path" .app)
    
    echo "Packaging $app_name..."
    
    # Create temporary directory
    local temp_dir="$RELEASE_DIR/temp_$app_name"
    mkdir -p "$temp_dir"
    
    # Copy app
    cp -R "$app_path" "$temp_dir/"
    
    # Create README for this app
    cat > "$temp_dir/README.txt" << EOF
$app_name

Installation:
1. Copy $app_name.app to /Applications
2. Open /Applications in Finder
3. Hold Command key and drag $app_name.app to Finder toolbar
4. Click the toolbar icon to open current folder in the app

For more apps and documentation, visit:
https://github.com/sozercan/OpenInCode
EOF
    
    # Create zip
    cd "$RELEASE_DIR"
    zip -r "${app_name}.zip" "temp_$app_name"
    
    # Remove temp directory
    rm -rf "temp_$app_name"
    
    echo "✓ Created ${app_name}.zip"
}

# Create individual zips
echo ""
echo "=== Creating individual app zips ==="
for app in "$BUILD_DIR"/*.app; do
    if [ -d "$app" ]; then
        package_app "$app"
    fi
done

# Create complete bundle zip
echo ""
echo "=== Creating complete bundle ==="
mkdir -p "$RELEASE_DIR/OpenIn-Complete"
cp -R "$BUILD_DIR"/*.app "$RELEASE_DIR/OpenIn-Complete/"

# Create main README for bundle
cat > "$RELEASE_DIR/OpenIn-Complete/README.txt" << EOF
OpenIn - Multi-Editor Finder Toolbar Apps v$VERSION

This collection includes apps for opening folders in various development tools directly from Finder.

Included Apps:
$(ls -d "$RELEASE_DIR/OpenIn-Complete"/*.app | xargs -n1 basename | sed 's/.app$//')

Installation:
1. Copy desired apps to /Applications
2. Open /Applications in Finder
3. Hold Command key and drag apps to Finder toolbar
4. Click toolbar icons to open current folder

Building from Source:
If you want to modify or add new apps, visit:
https://github.com/sozercan/OpenInCode

License:
Copyright Sertac Ozercan 2016. All rights reserved.
EOF

cd "$RELEASE_DIR"
zip -r "OpenIn-Complete-v$VERSION.zip" OpenIn-Complete
rm -rf OpenIn-Complete

echo ""
echo "=== Release package complete ==="
echo "Created files:"
ls -lh *.zip

echo ""
echo "Upload these zip files to your GitHub release:"
echo "- Individual app zips for selective downloads"
echo "- OpenIn-Complete-v$VERSION.zip for the full bundle"
