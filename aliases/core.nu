# ==============================================================================
# Core Aliases - Basic shortcuts
# ==============================================================================

# Navigation shortcuts
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias cd.. = cd ..

# Shell shortcuts
alias :q = exit
alias c = clear
alias q = exit
alias m = man

# Utility shortcuts
alias map = each
alias +x = chmod +x
alias z = zoxide

# File size
def fs [path: string] {
    ls $path | get size | first
}
