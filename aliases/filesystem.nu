# ==============================================================================
# Filesystem Aliases - File and directory operations
# ==============================================================================

# Better `rm` alternatives
# Use `rip` or `trash` if available for safer file deletion

# Option 1: `rip` - a safer and more user-friendly alternative to 'rm'
# see: https://github.com/nivekuil/rip
if (which rip | length) > 0 {
    alias rm = rip
}

# Option 2: `trash` - safer alternative to 'rm'
# see: https://github.com/andreafrancia/trash-cli
if (which trash | length) > 0 {
    alias rm = trash
}

# ==============================================================================
# Better `ls` with eza
# ==============================================================================

# Modern replacement for 'ls'
# see: https://github.com/eza-community/eza
if (which eza | length) > 0 {
    alias ls = eza
    alias l = eza -l
    alias ll = eza -l -g --icons
    alias lla = eza -l -g --icons -a
}

# List only directories
alias lsd = ls -l | where type == dir

# List only hidden files
alias lsh = ls -a | where name =~ '^\.'

# ==============================================================================
# fzy - fuzzy finder
# ==============================================================================

# Note: fzy integration removed as the shell 'find' command conflicts
# with nushell's built-in 'find' command. Use native nushell commands instead:
# Example: ls **/* | where type == file | get name | fzy
