# ==============================================================================
# Claude Code Aliases
# see: https://docs.anthropic.com/en/docs/claude-code
# ==============================================================================

if (which claude | length) > 0 {
    alias cl = claude --dangerously-skip-permissions
}
