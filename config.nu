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
        metric: true
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
    footer_mode: 25
    float_precision: 2
    buffer_editor: null
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

# Apply FZF and BAT theme integration based on selected theme
let nu_theme = if ($env.NU_THEME? | is-empty) { "gruvbox" } else { $env.NU_THEME }

# Set FZF colors based on selected theme
if ($env.FZF_DEFAULT_OPTS? | is-not-empty) {
    $env.FZF_DEFAULT_OPTS = match $nu_theme {
        "gruvbox" => ($env.FZF_DEFAULT_OPTS + " " + 
            "--color=fg:#d5c4a1,bg:#282828,hl:#fabd2f " +
            "--color=fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f " +
            "--color=info:#83a598,prompt:#fb4934,pointer:#b8bb26 " +
            "--color=marker:#8ec07c,spinner:#d3869b,header:#8ec07c")
        "nord" => ($env.FZF_DEFAULT_OPTS + " " +
            "--color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1 " +
            "--color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1 " +
            "--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac " +
            "--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b")
        "catppuccin" => ($env.FZF_DEFAULT_OPTS + " " +
            "--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 " +
            "--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 " +
            "--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796")
        _ => $env.FZF_DEFAULT_OPTS
    }
}

# Set BAT theme based on selected theme
$env.BAT_THEME = match $nu_theme {
    "gruvbox" => "gruvbox-dark"
    "nord" => "Nord"
    "catppuccin" => "Catppuccin-macchiato"
    _ => "gruvbox-dark"
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
# Note: Starship init cannot be sourced here due to parse-time file existence checks
# To use starship, run: starship init nu | save -f ~/.cache/starship/init.nu
# Then manually add: source ~/.cache/starship/init.nu to your config

# Initialize zoxide (smart cd)
# Note: Zoxide init cannot be sourced here due to parse-time file existence checks
# To use zoxide, run: zoxide init nushell | save -f ~/.cache/zoxide.nu
# Then manually add: source ~/.cache/zoxide.nu to your config

# Initialize carapace (completions)
# Note: Carapace init cannot be sourced here due to parse-time file existence checks  
# To use carapace, run: carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
# Then manually add: source ~/.cache/carapace/init.nu to your config

# ==============================================================================
# Local Configuration
# ==============================================================================

# Load local machine-specific configurations (not tracked in git)
# Note: source requires literal paths at parse time, so optional local configs
# cannot be conditionally sourced. To use local config, create ~/.nu-config.local
# and it will be loaded automatically if it exists.
