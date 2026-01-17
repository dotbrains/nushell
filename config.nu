# ==============================================================================
# Nushell Configuration
# ==============================================================================
#
# This file is loaded after env.nu and contains shell-specific configurations,
# aliases, custom commands, and interactive shell settings.

# ==============================================================================
# Shell Settings
# ==============================================================================

$env.config = {
    show_banner: false
    
    ls: {
        use_ls_colors: true
        clickable_links: true
    }
    
    rm: {
        always_trash: false
    }
    
    table: {
        mode: rounded
        index_mode: always
        show_empty: true
        trim: {
            methodology: wrapping
            wrapping_try_keep_words: true
        }
    }
    
    explore: {
        help_banner: true
        exit_esc: true
        command_bar_text: '#C4C9C6'
        status_bar_background: {fg: '#1D1F21', bg: '#C4C9C6'}
        highlight: {bg: 'yellow', fg: 'black'}
        status: {
            error: {bg: 'yellow', fg: 'blue'}
            warn: {}
            info: {}
        }
        try: {
            border_color: 'red'
        }
        table: {
            split_line: '#404040'
            cursor: true
            line_index: true
            line_head_top: true
            line_head_bottom: true
            line_shift: true
            line_index: true
        }
        config: {
            cursor_color: {bg: 'yellow', fg: 'black'}
        }
    }
    
    history: {
        max_size: 100_000
        sync_on_enter: true
        file_format: "sqlite"
        isolation: false
    }
    
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
        external: {
            enable: true
            max_results: 100
            completer: null
        }
    }
    
    filesize: {
        metric: false
        format: "auto"
    }
    
    cursor_shape: {
        emacs: line
        vi_insert: block
        vi_normal: underscore
    }
    
    color_config: (if ("~/.config/nushell/colorscheme/colorscheme.nu" | path expand | path exists) {
        use ~/.config/nushell/colorscheme/colorscheme.nu get_theme
        get_theme
    } else {
        {}
    })
    use_grid_icons: true
    footer_mode: "25"
    float_precision: 2
    buffer_editor: "nvim"
    use_ansi_coloring: true
    bracketed_paste: true
    edit_mode: emacs
    shell_integration: true
    render_right_prompt_on_last_line: false
    use_kitty_protocol: false
    highlight_resolved_externals: false
    
    hooks: {
        pre_prompt: [{ null }]
        pre_execution: [{ null }]
        env_change: {
            PWD: [{|before, after| null }]
        }
        display_output: "if (term size).columns >= 100 { table -e } else { table }"
        command_not_found: { null }
    }
    
    menus: [
        {
            name: completion_menu
            only_buffer_difference: false
            marker: "| "
            type: {
                layout: columnar
                columns: 4
                col_width: 20
                col_padding: 2
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
        {
            name: history_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
        {
            name: help_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: description
                columns: 4
                col_width: 20
                col_padding: 2
                selection_rows: 4
                description_rows: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
    ]
    
    keybindings: [
        {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                ]
            }
        }
        {
            name: completion_previous
            modifier: shift
            keycode: backtab
            mode: [emacs, vi_normal, vi_insert]
            event: { send: menuprevious }
        }
        {
            name: history_menu
            modifier: control
            keycode: char_r
            mode: [emacs, vi_insert, vi_normal]
            event: { send: menu name: history_menu }
        }
        {
            name: help_menu
            modifier: none
            keycode: f1
            mode: [emacs, vi_insert, vi_normal]
            event: { send: menu name: help_menu }
        }
    ]
}

# ==============================================================================
# Theme Configuration
# ==============================================================================
# Themes are now loaded from colorscheme/colorscheme.nu
# Available themes: gruvbox, nord, catppuccin
# Set the NU_THEME environment variable to change themes

# ==============================================================================
# Load Modular Configurations
# ==============================================================================

# Load colorscheme (must be loaded before config to set theme)
if ("~/.config/nushell/colorscheme/colorscheme.nu" | path expand | path exists) {
    use ~/.config/nushell/colorscheme/colorscheme.nu *
}

# Load aliases
if ("~/.config/nushell/aliases/aliases.nu" | path expand | path exists) {
    source ~/.config/nushell/aliases/aliases.nu
}

# Load custom functions/commands
if ("~/.config/nushell/functions/functions.nu" | path expand | path exists) {
    source ~/.config/nushell/functions/functions.nu
}

# Load keybindings
if ("~/.config/nushell/keybindings/keybindings.nu" | path expand | path exists) {
    source ~/.config/nushell/keybindings/keybindings.nu
}

# ==============================================================================
# External Tool Initialization
# ==============================================================================

# Initialize starship prompt
if (which starship | length) > 0 {
    try {
        mkdir ~/.cache/starship
        ^starship init nu | save -f ~/.cache/starship/init.nu
        source ~/.cache/starship/init.nu
    } catch {
        # starship not available or failed to initialize
    }
}

# Initialize zoxide (smart cd)
if (which zoxide | length) > 0 {
    try {
        ^zoxide init nushell | save -f ~/.cache/zoxide.nu
        source ~/.cache/zoxide.nu
    } catch {
        # zoxide not available or failed to initialize
    }
}

# Initialize carapace (completions)
if (which carapace | length) > 0 {
    try {
        mkdir ~/.cache/carapace
        ^carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
        source ~/.cache/carapace/init.nu
    } catch {
        # carapace not available or failed to initialize
    }
}

# ==============================================================================
# Local Configuration
# ==============================================================================

# Load local machine-specific configurations (not tracked in git)
let local_config_file = ($env.HOME | path join ".nu-config.local")
if ($local_config_file | path exists) {
    source $local_config_file
}
