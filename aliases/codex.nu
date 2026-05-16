# ==============================================================================
# Codex CLI Aliases
# see: https://developers.openai.com/codex
# ==============================================================================

if (which codex | length) > 0 {
    alias cx = codex --full-auto
    alias cxd = codex --dangerously-bypass-approvals-and-sandbox
    alias cy = codex --yolo
}
