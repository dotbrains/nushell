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
    shell_integration: {
        osc2: true
        osc7: true
        osc8: true
        osc9_9: false
        osc133: true
        osc633: true
        reset_application_mode: true
    }
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
# Set SMU_THEME or NU_THEME environment variable to change themes

# ==============================================================================
# Load Modular Configurations
# ==============================================================================

# Load colorscheme (must be loaded before config to set theme)
if ("~/.config/nushell/colorscheme/colorscheme.nu" | path expand | path exists) {
    use ~/.config/nushell/colorscheme/colorscheme.nu *
}

# Apply FZF and BAT theme integration based on selected theme
let nu_theme = if ($env.NU_THEME? | is-not-empty) {
    $env.NU_THEME
} else if ($env.SMU_THEME? | is-not-empty) {
    $env.SMU_THEME
} else {
    "gruvbox"
}

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
        "tokyo-night" => ($env.FZF_DEFAULT_OPTS + " " +
            "--color=fg:#c0caf5,bg:#1a1b26,hl:#7aa2f7 " +
            "--color=fg+:#c0caf5,bg+:#283457,hl+:#7aa2f7 " +
            "--color=info:#bb9af7,prompt:#f7768e,pointer:#9ece6a " +
            "--color=marker:#7dcfff,spinner:#bb9af7,header:#7dcfff")
        "rose-pine" => ($env.FZF_DEFAULT_OPTS + " " +
            "--color=fg:#e0def4,bg:#191724,hl:#9ccfd8 " +
            "--color=fg+:#e0def4,bg+:#393552,hl+:#9ccfd8 " +
            "--color=info:#c4a7e7,prompt:#eb6f92,pointer:#31748f " +
            "--color=marker:#ebbcba,spinner:#c4a7e7,header:#ebbcba")
        "dracula" => ($env.FZF_DEFAULT_OPTS + " " +
            "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 " +
            "--color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 " +
            "--color=info:#ff79c6,prompt:#ff5555,pointer:#50fa7b " +
            "--color=marker:#8be9fd,spinner:#ff79c6,header:#8be9fd")
        "everforest" => ($env.FZF_DEFAULT_OPTS + " " +
            "--color=fg:#d3c6aa,bg:#2d353b,hl:#7fbbb3 " +
            "--color=fg+:#d3c6aa,bg+:#3a515d,hl+:#7fbbb3 " +
            "--color=info:#d699b6,prompt:#e67e80,pointer:#a7c080 " +
            "--color=marker:#83c092,spinner:#d699b6,header:#83c092")
        "solarized" => ($env.FZF_DEFAULT_OPTS + " " +
            "--color=fg:#839496,bg:#002b36,hl:#268bd2 " +
            "--color=fg+:#93a1a1,bg+:#073642,hl+:#268bd2 " +
            "--color=info:#6c71c4,prompt:#dc322f,pointer:#859900 " +
            "--color=marker:#2aa198,spinner:#6c71c4,header:#2aa198")
        "kanagawa" => ($env.FZF_DEFAULT_OPTS + " " +
            "--color=fg:#dcd7ba,bg:#1f1f28,hl:#7e9cd8 " +
            "--color=fg+:#dcd7ba,bg+:#2d4f67,hl+:#7e9cd8 " +
            "--color=info:#957fb8,prompt:#c34043,pointer:#76946a " +
            "--color=marker:#7aa89f,spinner:#957fb8,header:#7aa89f")
        _ => $env.FZF_DEFAULT_OPTS
    }
}

# Set BAT theme based on selected theme
$env.BAT_THEME = match $nu_theme {
    "gruvbox" => "gruvbox-dark"
    "nord" => "Nord"
    "catppuccin" => "Catppuccin-macchiato"
    "tokyo-night" => "TokyoNight"
    "rose-pine" => "Rose Pine"
    "dracula" => "Dracula"
    "everforest" => "Everforest Dark"
    "solarized" => "Solarized (dark)"
    "kanagawa" => "Kanagawa"
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

# Initialize prompt
if $env.SMU_PROMPT == "starship-minimal" {
    if ("~/.config/starship-minimal.toml" | path expand | path exists) {
        $env.STARSHIP_CONFIG = ("~/.config/starship-minimal.toml" | path expand)
    }
}

const starship_init = if ("~/.cache/starship/init.nu" | path expand | path exists) {
    "~/.cache/starship/init.nu"
} else {
    null
}
source $starship_init

if $env.SMU_PROMPT == "classic" {
    $env.PROMPT_COMMAND = {||
        $"(whoami)@(sys host | get hostname):(pwd)> "
    }
}

# Initialize zoxide (smart cd)
# Bootstrapped automatically from env.nu into ~/.config/nushell/vendor/autoload/zoxide.nu,
# which Nushell auto-sources after config.nu. This satisfies zoxide doctor's
# "init must be last" check without needing manual setup.

# Initialize carapace (completions)
# Note: Carapace init cannot be sourced here due to parse-time file existence checks  
# To use carapace, run: carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
# Then manually add: source ~/.cache/carapace/init.nu to your config

# ==============================================================================
# Local Configuration
# ==============================================================================

# Load local machine-specific configurations (not tracked in git)
# This file should contain machine-specific aliases, functions, etc.
const local_config = if ("~/.nushell.local" | path expand | path exists) {
    "~/.nushell.local"
} else {
    null
}
source $local_config
