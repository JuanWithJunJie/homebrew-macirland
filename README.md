# MacIrland Homebrew

**Note:** Due to Homebrew sandbox restrictions, GUI applications are better distributed via direct download.

## Installation

### Direct Download (Recommended)

1. Download the latest release from:
   https://github.com/JuanWithJunJie/ai-dynamic-island/releases/latest

2. Unzip and move `MacIrland.app` to `/Applications`

### Homebrew (CLI only, limited)

For command-line access only:

```bash
brew install JuanWithJunJie/macirland/macirland
```

This installs the app to `$(brew --prefix)/share/MacIrland.app` and creates a `macirland` command that launches the app.

For full menu bar integration, manually move the app:
```bash
mv $(brew --prefix)/share/MacIrland.app /Applications/
```

## Uninstall

```bash
brew uninstall macirland
rm -rf $(brew --prefix)/share/MacIrland.app
rm -rf ~/.claude/hooks/macirland.py
```

## What is MacIrland?

MacIrland is a macOS AI CLI session observer that displays Claude Code status in a Dynamic Island-style interface at the top of your screen.

## Requirements

- macOS 14+
- Claude Code hook installed
