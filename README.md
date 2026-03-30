# nushell

[![Lint](https://github.com/dotbrains/nushell/actions/workflows/lint.yml/badge.svg?branch=master)](https://github.com/dotbrains/nushell/actions/workflows/lint.yml)
[![Tests](https://github.com/dotbrains/nushell/actions/workflows/tests.yml/badge.svg)](https://github.com/dotbrains/nushell/actions/workflows/tests.yml)
[![Release](https://github.com/dotbrains/nushell/actions/workflows/release.yml/badge.svg)](https://github.com/dotbrains/nushell/actions/workflows/release.yml)
[![License: PolyForm Shield 1.0.0](https://img.shields.io/badge/License-PolyForm%20Shield%201.0.0-blue.svg)](https://polyformproject.org/licenses/shield/1.0.0/)

This repository contains my sensible defaults for nushell.

## Usage

The contents of this repository should be placed in your `$HOME/.config`.

```bash
git clone https://github.com/dotbrains/nushell.git $HOME/.config/nushell
```

## Overview

[Nushell](https://www.nushell.sh/) (Nu) is a modern, cross-platform shell that works with structured
data. Unlike traditional shells that work with strings, Nushell pipelines use structured data, making
it safer and more powerful for data manipulation.

## Installation

To install Nushell:

```bash
bash ~/set-me-up/modules/universal/nushell/nushell.sh
```

This will install Nushell via Homebrew on macOS, Linux, or BSD using [set-me-up universal modules](https://github.com/dotbrains/set-me-up-universal-modules).

If you are **not** using set-me-up universal modules, you can install Nushell directly:

**On macOS (with Homebrew):**

```bash
brew install nushell
```

**On Ubuntu/Debian:**

```bash
sudo apt update
sudo apt install nushell
```

**On Arch Linux:**

```bash
sudo pacman -S nushell
```

See the official [Nushell website](https://www.nushell.sh/book/installation.html)
for more installation options including Windows, portable releases, and compiling from source.

## Structure

```text
~/.config/nushell/
├── config.nu              # Main configuration file
├── env.nu                 # Environment variables and PATH
├── aliases/               # Modular alias definitions
│   ├── aliases.nu         # Main alias loader
│   ├── core.nu            # Core shortcuts (cd, exit, etc.)
│   ├── filesystem.nu      # File operations (ls, rm, etc.)
│   ├── git.nu             # Git-related aliases
│   ├── system.nu          # System utilities
│   ├── tools.nu           # External tool aliases
│   ├── claude.nu          # Claude Code aliases
│   └── codex.nu           # Codex CLI aliases
├── functions/             # Custom commands
│   └── functions.nu       # Utility functions
├── variables/             # Environment variable modules
│   ├── variables.nu       # Main variables loader
│   ├── version-managers.nu # Version manager configs
│   └── tools.nu           # Tool-specific variables
├── colorscheme/           # Theme and color settings
│   └── colorscheme.nu     # Theme definitions (gruvbox, nord, catppuccin)
├── keybindings/           # Custom key bindings
│   └── keybindings.nu     # Custom keybinding definitions
├── plugins/               # Nushell plugins
│   └── README.md          # Plugin documentation
└── README.md              # This file
```

## Configuration Files

### env.nu

Loaded first, before `config.nu`. Contains:

- XDG Base Directory Specification variables
- Editor configuration (EDITOR, VISUAL)
- Homebrew initialization for macOS and Linux
- PATH configuration
- Version manager initialization (mise)
- Tool-specific environment variables (fzf, etc.)

### config.nu

Main configuration file containing:

- Shell settings (history, completions, table formatting, etc.)
- Menu and keybinding definitions
- Loading of modular configurations (colorscheme, aliases, functions)
- External tool initialization (starship, zoxide, carapace)

### colorscheme/colorscheme.nu

Theme configuration with three built-in themes:

- **gruvbox** (default): Warm, retro groove colors
- **nord**: Arctic, north-bluish color palette
- **catppuccin**: Soothing pastel theme (Macchiato variant)

The colorscheme also configures:

- FZF colors to match the selected theme
- Bat syntax highlighting theme

Change themes by setting the `NU_THEME` environment variable:

```bash
export NU_THEME=nord  # in your shell rc file
```

### variables/

Modular environment variable configurations:

- `variables.nu`: Main loader for variable modules
- `version-managers.nu`: Python (pyenv), Ruby (rbenv), Node (nvm) paths
- `tools.nu`: FZF preview, pnpm, LM Studio, Ruby gems paths

## Features

### Structured Data

Nushell works with structured data by default:

```nushell
# List files as a table
ls | where size > 1mb | sort-by modified

# Work with JSON, YAML, CSV, etc.
open package.json | get dependencies

# HTTP requests return structured data
http get https://api.github.com/repos/nushell/nushell | get stargazers_count
```

### Modern Tools Integration

- **starship**: Cross-shell prompt with Git integration
- **zoxide**: Smart directory jumper (z command)
- **eza**: Modern ls replacement with colors and icons
- **mise**: Polyglot version manager
- **carapace**: Multi-shell completion generator

### Custom Commands

The configuration includes useful custom commands:

- `mkcd <dir>` - Create directory and cd into it
- `extract <file>` - Extract various archive formats
- `sysinfo` - Display system information
- `gs` - Git status in short format
- `glog [n]` - Pretty git log
- `gbr` - Show git branches by date
- `serve [port]` - Start HTTP server
- `backup <file>` - Create timestamped backup

### Aliases

Organized aliases for:

- Navigation shortcuts (.., ..., cd..)
- Shell operations (:q, c, q)
- File operations with modern tools (eza, rip/trash)
- Git operations (acp, lg)
- System utilities (localip, publicip)
- External tools (wttr, piknik, commitizen)
- Claude Code (`claude` with opus model, `cl` for skip-permissions)
- Codex CLI (`codex` with gpt-5.4 model, `cx` for full-auto, `cxd` for bypass-all)

## Advanced Usage

### Starting Nushell

After installation, launch Nushell by typing:

```bash
nu
```

### Making Nushell Your Default Shell

To set Nushell as your default shell:

1. Add Nushell to `/etc/shells`:

   ```bash
   which nu | sudo tee -a /etc/shells
   ```

2. Change your default shell:

   ```bash
   chsh -s $(which nu)
   ```

### Local Configuration

For machine-specific configurations that shouldn't be tracked in git:

- Create `~/.nu-env.local` for environment variables
- Create `~/.nu-config.local` for shell configurations

These files will be automatically sourced if they exist.

## Customization

### Adding Aliases

1. Navigate to the appropriate file in `aliases/`:
   - `core.nu` - Basic shortcuts
   - `filesystem.nu` - File operations
   - `git.nu` - Git commands
   - `system.nu` - System utilities
   - `tools.nu` - External tools

2. Add your alias:

   ```nushell
   alias myalias = my command here
   ```

3. Reload configuration:

   ```nushell
   source ~/.config/nushell/config.nu
   ```

### Adding Custom Commands

Add custom commands to `functions/functions.nu`:

```nushell
# Custom command with parameters
def mycommand [name: string, count: int = 5] {
    1..$count | each { |n| print $"Hello ($name) #($n)" }
}
```

### Changing Theme

Change the color theme by setting the `NU_THEME` environment variable:

```bash
# Add to your shell profile (e.g., ~/.bashrc, ~/.zshrc)
export NU_THEME=nord

# Or set it in Nushell's env.nu
$env.NU_THEME = "catppuccin"
```

Available themes:

- `gruvbox` (default): Warm, retro groove colors
- `nord`: Arctic, north-bluish color palette
- `catppuccin`: Soothing pastel theme

You can also customize themes by editing `colorscheme/colorscheme.nu` to:

- Modify existing theme colors
- Add new custom themes
- Adjust FZF and Bat color integration

## Documentation

- [Nushell Book](https://www.nushell.sh/book/) - Complete guide to Nushell
- [Command Reference](https://www.nushell.sh/commands/) - All built-in commands
- [Cookbook](https://www.nushell.sh/cookbook/) - Practical examples
- [Language Reference](https://www.nushell.sh/lang-guide/) - Language details

## Plugins

Nushell supports plugins to extend functionality. See `plugins/README.md` for detailed documentation.

### Quick Start with Plugins

Install and register a plugin:

```bash
# Install via cargo
cargo install nu_plugin_query

# Register with Nushell
plugin add ~/.cargo/bin/nu_plugin_query

# List installed plugins
plugin list
```

Recommended plugins:

- **nu_plugin_query**: Query JSON, XML, and other structured data
- **nu_plugin_formats**: SQLite, msgpack, and other format support
- **nu_plugin_gstat**: Enhanced git status information

## Tips

1. **Tab Completion**: Nushell has powerful fuzzy completion. Press Tab to see options.

2. **Help System**: Use `help <command>` to get detailed information about any command.

3. **Error Messages**: Nushell provides detailed, helpful error messages with suggestions.

4. **Data Exploration**: Use `explore` command for interactive data viewing.

5. **History**: Press Ctrl+R for fuzzy history search.

6. **Theming**: Change themes with `$env.NU_THEME = "nord"` or `"catppuccin"`.

7. **Structured Pipelines**: Leverage Nushell's structured data - no more parsing strings!

8. **Plugin System**: Extend functionality with Rust-based or script-based plugins.

9. **Cross-platform**: Same config works on macOS, Linux, and Windows.

10. **Modern Tools**: Integrates seamlessly with starship, zoxide, eza, and mise.

## Troubleshooting

### Command Not Found

If a command isn't found, check if it's installed:

```nushell
which <command>
```

### PATH Issues

Check your PATH:

```nushell
$env.PATH | each { |p| print $p }
```

### Configuration Errors

If there are syntax errors in configuration:

```nushell
# Check env.nu
nu -c "source ~/.config/nushell/env.nu"

# Check config.nu
nu -c "source ~/.config/nushell/config.nu"
```

## Contributing

Improvements to this configuration are welcome! Please ensure:

- Code is well-commented
- Follows the modular structure
- Works on macOS, Linux, and BSD
- Includes appropriate documentation

## License

Licensed under [PolyForm Shield 1.0.0](https://polyformproject.org/licenses/shield/1.0.0/).
See [LICENSE](LICENSE) for details.
