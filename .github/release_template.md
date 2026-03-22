# OpenIn v1.0.0

A collection of Finder toolbar apps to open current folder in your favorite development tools.

## 🚀 What's New

- Complete rewrite using AppleScript for better reliability
- Support for 12 popular development tools
- Individual app downloads and complete bundle
- Universal build script for easy customization

## 📦 Downloads

### Individual Apps
Pick and choose the apps you need:

- **[Open in VS Code](Open%20in%20vscode.zip)** - Microsoft's popular code editor
- **[Open in Windsurf](Open%20in%20windsurf.zip)** - AI-powered IDE by Exafunction
- **[Open in Cursor](Open%20in%20cursor.zip)** - AI-first code editor
- **[Open in Zed](Open%20in%20zed.zip)** - High-performance code editor
- **[Open in Sublime Text](Open%20in%20sublime.zip)** - Sophisticated text editor
- **[Open in Nova](Open%20in%20nova.zip)** - Native code editor by Panic
- **[Open in VimR](Open%20in%20vimr.zip)** - Vim for macOS
- **[Open in Ghostty](Open%20in%20ghostty.zip)** - Modern terminal emulator
- **[Open in Warp](Open%20in%20warp.zip)** - AI-powered terminal
- **[Open in iTerm2](Open%20in%20iterm2.zip)** - Feature-rich terminal replacement
- **[Open in WezTerm](Open%20in%20wezterm.zip)** - Cross-platform terminal emulator
- **[Open in TablePlus](Open%20in%20tableplus.zip)** - Modern database client

### Complete Bundle
**[OpenIn-Complete-v1.0.0.zip](OpenIn-Complete-v1.0.0.zip)** - All 12 apps in one download (4.7MB)

## 📖 Installation

1. Download and unzip the desired app(s)
2. Copy the `.app` file to `/Applications`
3. Open `/Applications` in Finder
4. Hold **Command key** and drag the app to your Finder toolbar
5. Click the toolbar icon to open the current folder

## 🛠️ Building from Source

Want to add a new app or modify existing ones?

```bash
git clone https://github.com/sozercan/OpenInCode.git
cd OpenInCode

# Build all apps
./build_all.sh

# Build specific category
./build_all.sh ides
./build_all.sh terminals

# Package for release
./package_release.sh
```

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Add new apps in the appropriate `apps/` subdirectory
3. Update this README
4. Submit a pull request

## 📄 License

Copyright Sertac Ozercan 2016. All rights reserved.
