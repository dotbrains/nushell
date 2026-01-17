# ==============================================================================
# Version Manager Environment Variables
# ==============================================================================

# Python version manager (pyenv)
$env.PYENV_ROOT = ($env.XDG_DATA_HOME | path join "pyenv")

# Ruby version manager (rbenv)
$env.RBENV_ROOT = ($env.XDG_DATA_HOME | path join "rbenv")

# Node version manager (nvm)
$env.NVM_DIR = ($env.XDG_DATA_HOME | path join "nvm")

# ==============================================================================
# Version Manager Initialization
# ==============================================================================
# Note: Most version managers are initialized via mise in env.nu
# These are fallback configurations if using standalone version managers

# pyenv initialization (if not using mise)
if (which pyenv | length) > 0 and (which mise | length) == 0 {
    # Add pyenv to PATH if needed
    if ($env.PYENV_ROOT | path join "bin" | path exists) {
        $env.PATH = ($env.PATH | prepend ($env.PYENV_ROOT | path join "bin"))
    }
}

# rbenv initialization (if not using mise)
if (which rbenv | length) > 0 and (which mise | length) == 0 {
    # Add rbenv to PATH if needed
    if ($env.RBENV_ROOT | path join "bin" | path exists) {
        $env.PATH = ($env.PATH | prepend ($env.RBENV_ROOT | path join "bin"))
    }
}
