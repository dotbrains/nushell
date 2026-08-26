# ==============================================================================
# Aliases - Load all alias modules
# ==============================================================================
#
# This file sources all modular alias files from the aliases/ directory.
# Each module contains related aliases organized by category.

let alias_dir = ($env.HOME | path join ".config" "nushell" "aliases")

# Core shortcuts (cd, exit, clear, etc.)
if (($alias_dir | path join "core.nu") | path exists) {
    source ~/.config/nushell/aliases/core.nu
}

# File and directory operations (ls, rm, etc.)
if (($alias_dir | path join "filesystem.nu") | path exists) {
    source ~/.config/nushell/aliases/filesystem.nu
}

# Git-related aliases
if (($alias_dir | path join "git.nu") | path exists) {
    source ~/.config/nushell/aliases/git.nu
}

# System utilities
if (($alias_dir | path join "system.nu") | path exists) {
    source ~/.config/nushell/aliases/system.nu
}

# External tools
if (($alias_dir | path join "tools.nu") | path exists) {
    source ~/.config/nushell/aliases/tools.nu
}

# Claude Code
if (($alias_dir | path join "claude.nu") | path exists) {
    source ~/.config/nushell/aliases/claude.nu
}

# Codex CLI
if (($alias_dir | path join "codex.nu") | path exists) {
    source ~/.config/nushell/aliases/codex.nu
}

# Cursor Agent CLI
if (($alias_dir | path join "cursor.nu") | path exists) {
    source ~/.config/nushell/aliases/cursor.nu
}

# pi coding agent
if (($alias_dir | path join "pi.nu") | path exists) {
    source ~/.config/nushell/aliases/pi.nu
}
