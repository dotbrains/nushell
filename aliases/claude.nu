# ==============================================================================
# Claude Code Aliases
# see: https://docs.anthropic.com/en/docs/claude-code
# ==============================================================================

if (which claude | length) > 0 {
    alias claude = claude --model opus
    alias cl = claude --model opus --dangerously-skip-permissions
}
