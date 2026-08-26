# ==============================================================================
# Cursor Agent Aliases
# see: https://cursor.com/docs/agent/cli
# ==============================================================================

if (which agent | length) > 0 {
    alias ca = agent --yolo
    alias cap = agent -p
}
