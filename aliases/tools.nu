# ==============================================================================
# External Tools Aliases
# ==============================================================================

# Weather information
alias wttr = curl wttr.in

# ==============================================================================
# piknik - Copy/paste anything over the network
# see: https://github.com/jedisct1/piknik
# ==============================================================================

if (which piknik | length) > 0 {
    # pkc: read the content to copy to the clipboard from STDIN
    alias pkc = piknik -copy
    
    # pkp: paste the clipboard content
    alias pkp = piknik -paste
    
    # pkm: move the clipboard content
    alias pkm = piknik -move
    
    # pkz: delete the clipboard content
    def pkz [] {
        "" | piknik -copy
    }
    
    # pkpr: extract clipboard content sent using the pkfr command
    def pkpr [] {
        piknik -paste | tar xzhpvf -
    }
}

# ==============================================================================
# commitizen - Simple commit conventions for internet citizens
# see: https://commitizen.github.io/cz-cli/
# ==============================================================================

if (which npx | length) > 0 {
    alias cz = npx cz
}
