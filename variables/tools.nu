# ==============================================================================
# Tool-specific Configuration
# ==============================================================================

# FZF configuration
if (which bat | length) > 0 {
    $env.FZF_PREVIEW_FILE_CMD = "bat --style=numbers --color=always --line-range :500"
}

# Additional FZF options (base options are set in env.nu)
# Add any extra FZF configuration here

# ==============================================================================
# Language/Runtime Specific
# ==============================================================================

# pnpm configuration
$env.PNPM_HOME = ($env.HOME | path join ".local" "share" "pnpm")
if not ($env.PATH | any {|p| $p == $env.PNPM_HOME}) {
    $env.PATH = ($env.PATH | prepend $env.PNPM_HOME)
}

# LM Studio CLI
let lmstudio_bin = ($env.HOME | path join ".lmstudio" "bin")
if ($lmstudio_bin | path exists) {
    if not ($env.PATH | any {|p| $p == $lmstudio_bin}) {
        $env.PATH = ($env.PATH | append $lmstudio_bin)
    }
}

# Ruby gems path
if (which gem | length) > 0 {
    let gems_bin = (^gem environment gemdir | str trim | path join "bin")
    if ($gems_bin | path exists) and not ($env.PATH | any {|p| $p == $gems_bin}) {
        $env.PATH = ($env.PATH | append $gems_bin)
    }
}
