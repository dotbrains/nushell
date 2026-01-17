# ==============================================================================
# Variables - Load all variable modules
# ==============================================================================
#
# This file sources all modular variable files from the variables/ directory.
# Each module contains related environment variables and settings.
# 
# Note: Most environment variables are set in env.nu, but these modules
# provide additional tool-specific and version manager configurations.

# Version manager environment variables
source ~/.config/nushell/variables/version-managers.nu

# Tool-specific configuration
source ~/.config/nushell/variables/tools.nu
