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
# set-me-up Profile
# ==============================================================================

let smu_profile = ($env.XDG_CONFIG_HOME | path join "set-me-up" "profile.env")
if ($smu_profile | path exists) {
    open $smu_profile
    | lines
    | where {|line| $line =~ '^export SMU_(THEME|PROMPT)=' }
    | each {|line|
        let assignment = ($line | str replace 'export ' '')
        let parts = ($assignment | split row -n 2 '=')
        if ($parts | length) == 2 {
            let key = ($parts | get 0)
            let value = ($parts | get 1 | str trim --char '"')
            if ($key == "SMU_THEME" and ($env.SMU_THEME? | is-empty)) {
                load-env {SMU_THEME: $value}
            } else if ($key == "SMU_PROMPT" and ($env.SMU_PROMPT? | is-empty)) {
                load-env {SMU_PROMPT: $value}
            }
        }
    }
}

if ($env.SMU_THEME? | is-empty) {
    $env.SMU_THEME = "gruvbox"
}
if ($env.SMU_PROMPT? | is-empty) {
    $env.SMU_PROMPT = "starship"
}

# ==============================================================================
# Editor Configuration
# ==============================================================================

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# ==============================================================================
# Homebrew Configuration
# ==============================================================================

# Initialize Homebrew for macOS
if (sys host | get name) == "Darwin" {
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
if (sys host | get name) == "Linux" {
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
# worktrunk bootstrap (auto-loaded after config.nu, experimental nushell support)
# ==============================================================================

# Same rationale as the zoxide bootstrap below: materialise the init script
# into vendor/autoload so it's auto-sourced after config.nu.
# see: https://github.com/max-sixty/worktrunk
let worktrunk_autoload_dir = ($env.HOME | path join ".config" "nushell" "vendor" "autoload")
if (which wt | is-not-empty) {
    mkdir $worktrunk_autoload_dir
    wt config shell init nu | save -f ($worktrunk_autoload_dir | path join "wt.nu")
}

# ==============================================================================
# zoxide bootstrap (auto-loaded after config.nu)
# ==============================================================================

# Nushell can't conditionally `source` at parse time, so we materialise zoxide's
# init script into the vendor/autoload directory. Files in that directory are
# automatically sourced AFTER config.nu, which satisfies zoxide doctor's "init
# must be last" requirement.
# see: https://www.nushell.sh/book/configuration.html#auto-loading-libraries
let zoxide_autoload_dir = ($env.HOME | path join ".config" "nushell" "vendor" "autoload")
if (which zoxide | is-not-empty) {
    mkdir $zoxide_autoload_dir
    zoxide init nushell --cmd cd | save -f ($zoxide_autoload_dir | path join "zoxide.nu")
}

# ==============================================================================
# Local Configuration
# ==============================================================================

# Load local machine-specific environment configurations (not tracked in git)
# This file should contain machine-specific env vars (API keys, paths, etc.)
const local_env_config = if ("~/.nushell.local" | path expand | path exists) {
    "~/.nushell.local"
} else {
    null
}
source $local_env_config
