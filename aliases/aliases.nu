# ==============================================================================
# Aliases - Load all alias modules
# ==============================================================================
#
# This file sources all modular alias files from the aliases/ directory.
# Each module contains related aliases organized by category.

# Core shortcuts (cd, exit, clear, etc.)
source ~/.config/nushell/aliases/core.nu

# File and directory operations (ls, rm, etc.)
source ~/.config/nushell/aliases/filesystem.nu

# Git-related aliases
source ~/.config/nushell/aliases/git.nu

# System utilities
source ~/.config/nushell/aliases/system.nu

# External tools
source ~/.config/nushell/aliases/tools.nu
