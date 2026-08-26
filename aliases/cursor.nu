# ==============================================================================
# Cursor Agent CLI Aliases
# see: https://cursor.com/docs/agent/cli
# ==============================================================================

if (which agent | length) > 0 {
    alias ca = agent --force
    alias cap = agent -p
}
