#!/bin/bash

# Script to find bundle identifiers of common code editors and terminals

echo "Searching for installed development apps..."
echo "=========================================="

# List of common apps to check
declare -A apps=(
    # IDEs
    ["Visual Studio Code"]="com.microsoft.VSCode"
    ["VS Code Insiders"]="com.microsoft.VSCodeInsiders"
    ["Windsurf"]="com.exafunction.windsurf"
    ["Cursor"]="com.todesktop.cursor"
    ["Zed"]="dev.zed.Zed"
    ["Sublime Text"]="com.sublimetext.4"
    ["Nova"]="com.panic.Nova"
    ["VimR"]="com.qvacua.VimR"
    ["TextMate"]="com.macromates.TextMate"
    ["Atom"]="com.github.atom"
    ["Brackets"]="com.adobe.brackets"
    
    # Terminals
    ["Ghostty"]="dev.mitchellh.ghostty"
    ["Warp"]="dev.warp.Warp-Stable"
    ["iTerm2"]="com.googlecode.iterm2"
    ["WezTerm"]="com.github.wez.wezterm"
    ["Terminal"]="com.apple.Terminal"
    ["Alacritty"]="org.alacritty"
    
    # Other tools
    ["TablePlus"]="com.tinyapp.TablePlus"
    ["Sequel Pro"]="com.sequelpro.SequelPro"
    ["DataGrip"]="com.jetbrains.DataGrip"
    ["IntelliJ IDEA"]="com.jetbrains.intellij"
    ["PyCharm"]="com.jetbrains.pycharm"
    ["WebStorm"]="com.jetbrains.WebStorm"
)

found_apps=()

for app_name in "${!apps[@]}"; do
    bundle_id=$(osascript -e "id of app \"$app_name\"" 2>/dev/null)
    if [ -n "$bundle_id" ]; then
        echo "✓ $app_name: $bundle_id"
        found_apps+=("$app_name")
    fi
done

echo ""
echo "Found ${#found_apps[@]} installed apps."
echo ""
echo "To check a specific app, run:"
echo "osascript -e 'id of app \"App Name\"'"
