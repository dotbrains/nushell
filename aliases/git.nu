# ==============================================================================
# Git Aliases
# ==============================================================================

# Use hub instead of git if available
if (which hub | length) > 0 {
    alias git = hub
}

# Add, commit, and push in one command
def acp [...args] {
    git add -A
    git commit -v ...$args
    git push
}

# ==============================================================================
# lazygit
# ==============================================================================

if (which lazygit | length) > 0 {
    alias lg = lazygit
}
