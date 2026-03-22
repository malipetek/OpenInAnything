# OpenIn - Multi-Editor Finder Toolbar Apps

:open_file_folder: A collection of Finder toolbar apps to open current folder in your favorite development tools.

## Overview

This project provides simple AppleScript-based apps that you can add to your Finder toolbar to quickly open folders in various IDEs, terminals, and other development tools. Each app is lightweight, reliable, and integrates seamlessly with macOS.

## Supported Applications

### IDEs & Code Editors
- **Visual Studio Code** - Microsoft's popular code editor
- **Windsurf** - AI-powered IDE by Exafunction
- **Cursor** - AI-first code editor
- **Zed** - High-performance code editor by Zed Industries
- **Sublime Text** - Sophisticated text editor
- **Nova** - Native code editor by Panic

### Terminals
- **Ghostty** - Modern terminal emulator
- **Warp** - AI-powered terminal
- **iTerm2** - Feature-rich terminal replacement
- **WezTerm** - Cross-platform terminal emulator

## Quick Start

### Building All Apps

```bash
# Build all apps
./build_all.sh

# Build specific category
./build_all.sh ides
./build_all.sh terminals
```

### Installation

1. **Build the apps** (see above)
2. **Copy to Applications folder:**
   ```bash
   cp -R build/*.app /Applications/
   ```
3. **Add to Finder toolbar:**
   - Open `/Applications` in Finder
   - Hold **Command key** and drag desired apps to the toolbar
   - Release to place them

### Usage

- Navigate to any folder in Finder
- Click the toolbar icon for your desired tool
- The folder will open in that application

## Project Structure

```
OpenInCode/
├── apps/
│   ├── ides/           # IDE and code editor scripts
│   ├── terminals/      # Terminal emulator scripts
│   ├── editors/        # Text editor scripts
│   └── others/         # Other utility scripts
├── build/              # Built applications
├── build_all.sh        # Universal build script
└── README.md
```

## Adding New Applications

1. Create a new `.applescript` file in the appropriate category folder
2. Use the template below:

```applescript
tell application "Finder"
    if exists (selection) then
        set theItem to (selection as alias)
    else
        set theItem to (target of front window as alias)
    end if
    set thePath to POSIX path of theItem
end tell

-- Check if it's a file and get parent directory if so
tell application "System Events"
    if thePath ends with "/" then
        set folderPath to thePath
    else
        set folderPath to (do shell script "dirname " & quoted form of thePath)
    end if
end tell

-- Open in YOUR_APP
do shell script "open -n -b \"BUNDLE_ID\" --args " & quoted form of folderPath
```

3. Replace `BUNDLE_ID` with the target app's bundle identifier
4. Run `./build_all.sh` to compile

### Finding Bundle Identifiers

To find an app's bundle identifier:
```bash
osascript -e 'id of app "App Name"'
```

Or use the helper script:
```bash
./find_editors.sh
```

## Troubleshooting

### App Doesn't Open from Toolbar

1. **Check permissions:**
   ```bash
   xattr -d com.apple.quarantine "/Applications/App Name.app"
   ```

2. **Verify bundle ID:**
   - Make sure the bundle identifier in the script matches the installed app

3. **Check Console.app:**
   - Look for error messages when clicking the toolbar icon

### Terminal Apps Don't Change Directory

Different terminals use different command-line flags:
- Ghostty/Warp: `--cwd=/path/to/folder`
- iTerm2: Uses AppleScript directly (see script)
- Others: Check app's documentation

## Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Add new apps in the appropriate category
3. Update this README
4. Submit a pull request

## License

Copyright Sertac Ozercan 2016. All rights reserved.

## Original Project

This is a modernized version of the original OpenInCode project, rewritten to use AppleScript for better compatibility and maintainability.
