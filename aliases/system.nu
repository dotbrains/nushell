# ==============================================================================
# System Utilities Aliases
# ==============================================================================

# Whois lookup
alias whois = whois -h whois-servers.net

# Get local IP address
def localip [] {
    if $nu.os-info.name == "macos" {
        ipconfig getifaddr en0
    } else if $nu.os-info.name == "linux" {
        hostname -I | split row ' ' | first
    }
}

# Get external IP address
def publicip [] {
    http get https://api.ipify.org
}
