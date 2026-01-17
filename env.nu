# ==============================================================================
# Nushell Environment Configuration
# ==============================================================================
#
# This file is loaded before config.nu and is used for setting up environment
# variables, PATH, and other environment-level configurations.

# ==============================================================================
# XDG Base Directory Specification
# ==============================================================================

$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.XDG_DATA_HOME = ($env.HOME | path join ".local" "share")
$env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
$env.XDG_STATE_HOME = ($env.HOME | path join ".local" "state")

# ==============================================================================
# Editor Configuration
# ==============================================================================

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# ==============================================================================
# Homebrew Configuration
# ==============================================================================

# Initialize Homebrew for macOS
if (sys | get host.name) == "Darwin" {
    if ("/opt/homebrew/bin/brew" | path exists) {
        ^/opt/homebrew/bin/brew shellenv | lines | each { |line|
            let parts = ($line | parse "{key}={value}")
            if ($parts | length) > 0 {
                let key = ($parts | get 0.key | str replace 'export ' '')
                let value = ($parts | get 0.value | str replace --all '"' '')
                load-env {$key: $value}
            }
        }
    } else if ("/usr/local/bin/brew" | path exists) {
        ^/usr/local/bin/brew shellenv | lines | each { |line|
            let parts = ($line | parse "{key}={value}")
            if ($parts | length) > 0 {
                let key = ($parts | get 0.key | str replace 'export ' '')
                let value = ($parts | get 0.value | str replace --all '"' '')
                load-env {$key: $value}
            }
        }
    }
}

# Initialize Homebrew for Linux
if (sys | get host.name) == "Linux" {
    if ("/home/linuxbrew/.linuxbrew/bin/brew" | path exists) {
        ^/home/linuxbrew/.linuxbrew/bin/brew shellenv | lines | each { |line|
            let parts = ($line | parse "{key}={value}")
            if ($parts | length) > 0 {
                let key = ($parts | get 0.key | str replace 'export ' '')
                let value = ($parts | get 0.value | str replace --all '"' '')
                load-env {$key: $value}
            }
        }
    }
}

# ==============================================================================
# PATH Configuration
# ==============================================================================

# Add common binary directories to PATH
$env.PATH = ($env.PATH | split row (char esep) | append [
    ($env.HOME | path join ".local" "bin")
    ($env.HOME | path join "bin")
    "/usr/local/bin"
    "/usr/local/sbin"
])

# ==============================================================================
# Version Managers
# ==============================================================================

# mise (polyglot version manager)
# Note: We don't activate mise here as it requires sourcing a file
# that may not exist at parse time. Instead, we rely on mise's
# automatic activation in interactive shells or manual activation.

# ==============================================================================
# Tool Configuration
# ==============================================================================

# fzf configuration
$env.FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border"

# Dotfiles location
$env.DOTFILES = ($env.HOME | path join "set-me-up")

# ==============================================================================
# Additional Variables and Tool Configuration
# ==============================================================================

# Load additional environment variables and tool configurations
# Note: This loads version manager vars and tool-specific PATH additions
if ("~/.config/nushell/variables/variables.nu" | path expand | path exists) {
    source ~/.config/nushell/variables/variables.nu
}

# ==============================================================================
# Local Configuration
# ==============================================================================

# Load local machine-specific environment configurations (not tracked in git)
let local_env_file = ($env.HOME | path join ".nu-env.local")
if ($local_env_file | path exists) {
    source $local_env_file
}
