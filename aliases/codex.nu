# ==============================================================================
# Codex CLI Aliases
# see: https://developers.openai.com/codex
# ==============================================================================

if (which codex | length) > 0 {
    alias codex = codex --model gpt-5.4
}
