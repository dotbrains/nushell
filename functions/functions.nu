# ==============================================================================
# Custom Functions and Commands
# ==============================================================================
#
# This file contains custom Nushell commands and utility functions.

# ==============================================================================
# Navigation Functions
# ==============================================================================

# Create a directory and cd into it
def mkcd [name: string] {
    mkdir $name
    cd $name
}

# ==============================================================================
# File Operations
# ==============================================================================

# Extract various archive formats
def extract [file: string] {
    if ($file | path exists) {
        match ($file | path parse | get extension) {
            "tar" => { tar -xvf $file }
            "tar.gz" | "tgz" => { tar -xzvf $file }
            "tar.bz2" | "tbz2" => { tar -xjvf $file }
            "tar.xz" | "txz" => { tar -xJvf $file }
            "gz" => { gunzip $file }
            "bz2" => { bunzip2 $file }
            "zip" => { unzip $file }
            "rar" => { unrar x $file }
            "7z" => { 7z x $file }
            _ => { print $"Unknown archive format: ($file)" }
        }
    } else {
        print $"File not found: ($file)"
    }
}

# ==============================================================================
# System Information
# ==============================================================================

# Show system information
def sysinfo [] {
    {
        os: $nu.os-info.name
        kernel: $nu.os-info.kernel_version
        hostname: (sys host | get hostname)
        uptime: (sys host | get uptime)
        shell: "nushell"
        shell_version: (version | get version)
    }
}

# ==============================================================================
# Git Functions
# ==============================================================================

# Git status in a pretty format
def gs [] {
    git status -sb
}

# Git log with a nice format
def glog [num: int = 10] {
    git log --oneline --graph --decorate -n $num
}

# Show all git branches sorted by last commit date
def gbr [] {
    git branch --sort=-committerdate
}

# ==============================================================================
# Docker Functions
# ==============================================================================

# Stop all running Docker containers
def dstop [] {
    docker ps -q | lines | each { |container| docker stop $container }
}

# Remove all stopped Docker containers
def dclean [] {
    docker ps -a -q | lines | each { |container| docker rm $container }
}

# ==============================================================================
# Development Helpers
# ==============================================================================

# Start a simple HTTP server
def serve [port: int = 8000] {
    if (which python3 | length) > 0 {
        python3 -m http.server $port
    } else if (which python | length) > 0 {
        python -m http.server $port
    } else {
        print "Python not found"
    }
}

# Find and kill process by port
def killport [port: int] {
    let pid = (lsof -ti:$port)
    if ($pid | is-empty) {
        print $"No process found on port ($port)"
    } else {
        kill -9 $pid
        print $"Killed process on port ($port)"
    }
}

# ==============================================================================
# Utility Functions
# ==============================================================================

# Get the current Git branch
def git-branch [] {
    git branch --show-current
}

# Create a backup of a file with timestamp
def backup [file: string] {
    let timestamp = (date now | format date "%Y%m%d_%H%M%S")
    let backup_name = $"($file).($timestamp).backup"
    cp $file $backup_name
    print $"Backup created: ($backup_name)"
}

# Search for text in files recursively
def search [pattern: string, path: string = "."] {
    rg -n $pattern $path
}
