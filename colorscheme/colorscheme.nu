# ==============================================================================
# Nushell Colorscheme Configuration
# ==============================================================================

# ==============================================================================
# Theme Selection
# ==============================================================================

# Available themes: gruvbox, nord, catppuccin, tokyo-night, rose-pine,
# dracula, everforest, solarized, kanagawa
# Set SMU_THEME or NU_THEME environment variable to change (default: gruvbox)

# ==============================================================================
# Theme Definitions
# ==============================================================================

# Gruvbox Dark Medium Theme
export def gruvbox_theme [] {
    {
        separator: "#d5c4a1"
        leading_trailing_space_bg: { attr: n }
        header: { fg: "#b8bb26" attr: b }
        empty: "#83a598"
        bool: "#d5c4a1"
        int: "#d3869b"
        filesize: "#8ec07c"
        duration: "#d5c4a1"
        date: { fg: "#d3869b" attr: b }
        range: "#d5c4a1"
        float: "#d3869b"
        string: "#b8bb26"
        nothing: "#d5c4a1"
        binary: "#d5c4a1"
        cellpath: "#d5c4a1"
        row_index: { fg: "#b8bb26" attr: b }
        record: "#d5c4a1"
        list: "#d5c4a1"
        block: "#83a598"
        hints: "#665c54"
        search_result: { fg: "#fb4934" bg: "#d5c4a1" }
        shape_and: { fg: "#d3869b" attr: b }
        shape_binary: { fg: "#d3869b" attr: b }
        shape_block: { fg: "#83a598" attr: b }
        shape_bool: "#8ec07c"
        shape_closure: { fg: "#8ec07c" attr: b }
        shape_custom: "#b8bb26"
        shape_datetime: { fg: "#8ec07c" attr: b }
        shape_directory: "#83a598"
        shape_external: "#83a598"
        shape_externalarg: { fg: "#b8bb26" attr: b }
        shape_filepath: "#83a598"
        shape_flag: { fg: "#83a598" attr: b }
        shape_float: { fg: "#d3869b" attr: b }
        shape_garbage: { fg: "#ffffff" bg: "#fb4934" attr: b }
        shape_globpattern: { fg: "#8ec07c" attr: b }
        shape_int: { fg: "#d3869b" attr: b }
        shape_internalcall: { fg: "#8ec07c" attr: b }
        shape_list: { fg: "#8ec07c" attr: b }
        shape_literal: "#83a598"
        shape_match_pattern: "#b8bb26"
        shape_matching_brackets: { attr: u }
        shape_nothing: "#8ec07c"
        shape_operator: "#fabd2f"
        shape_or: { fg: "#d3869b" attr: b }
        shape_pipe: { fg: "#d3869b" attr: b }
        shape_range: { fg: "#fabd2f" attr: b }
        shape_record: { fg: "#8ec07c" attr: b }
        shape_redirection: { fg: "#d3869b" attr: b }
        shape_signature: { fg: "#b8bb26" attr: b }
        shape_string: "#b8bb26"
        shape_string_interpolation: { fg: "#8ec07c" attr: b }
        shape_table: { fg: "#83a598" attr: b }
        shape_variable: "#d3869b"
        shape_vardecl: "#d3869b"
    }
}

# Nord Theme
export def nord_theme [] {
    {
        separator: "#e5e9f0"
        leading_trailing_space_bg: { attr: n }
        header: { fg: "#a3be8c" attr: b }
        empty: "#81a1c1"
        bool: "#e5e9f0"
        int: "#b48ead"
        filesize: "#88c0d0"
        duration: "#e5e9f0"
        date: { fg: "#b48ead" attr: b }
        range: "#e5e9f0"
        float: "#b48ead"
        string: "#a3be8c"
        nothing: "#e5e9f0"
        binary: "#e5e9f0"
        cellpath: "#e5e9f0"
        row_index: { fg: "#a3be8c" attr: b }
        record: "#e5e9f0"
        list: "#e5e9f0"
        block: "#81a1c1"
        hints: "#4c566a"
        search_result: { fg: "#bf616a" bg: "#e5e9f0" }
        shape_and: { fg: "#b48ead" attr: b }
        shape_binary: { fg: "#b48ead" attr: b }
        shape_block: { fg: "#81a1c1" attr: b }
        shape_bool: "#88c0d0"
        shape_closure: { fg: "#88c0d0" attr: b }
        shape_custom: "#a3be8c"
        shape_datetime: { fg: "#88c0d0" attr: b }
        shape_directory: "#81a1c1"
        shape_external: "#81a1c1"
        shape_externalarg: { fg: "#a3be8c" attr: b }
        shape_filepath: "#81a1c1"
        shape_flag: { fg: "#81a1c1" attr: b }
        shape_float: { fg: "#b48ead" attr: b }
        shape_garbage: { fg: "#ffffff" bg: "#bf616a" attr: b }
        shape_globpattern: { fg: "#88c0d0" attr: b }
        shape_int: { fg: "#b48ead" attr: b }
        shape_internalcall: { fg: "#88c0d0" attr: b }
        shape_list: { fg: "#88c0d0" attr: b }
        shape_literal: "#81a1c1"
        shape_match_pattern: "#a3be8c"
        shape_matching_brackets: { attr: u }
        shape_nothing: "#88c0d0"
        shape_operator: "#ebcb8b"
        shape_or: { fg: "#b48ead" attr: b }
        shape_pipe: { fg: "#b48ead" attr: b }
        shape_range: { fg: "#ebcb8b" attr: b }
        shape_record: { fg: "#88c0d0" attr: b }
        shape_redirection: { fg: "#b48ead" attr: b }
        shape_signature: { fg: "#a3be8c" attr: b }
        shape_string: "#a3be8c"
        shape_string_interpolation: { fg: "#88c0d0" attr: b }
        shape_table: { fg: "#81a1c1" attr: b }
        shape_variable: "#b48ead"
        shape_vardecl: "#b48ead"
    }
}

# Catppuccin Macchiato Theme
export def catppuccin_theme [] {
    {
        separator: "#cad3f5"
        leading_trailing_space_bg: { attr: n }
        header: { fg: "#a6da95" attr: b }
        empty: "#8aadf4"
        bool: "#cad3f5"
        int: "#c6a0f6"
        filesize: "#91d7e3"
        duration: "#cad3f5"
        date: { fg: "#c6a0f6" attr: b }
        range: "#cad3f5"
        float: "#c6a0f6"
        string: "#a6da95"
        nothing: "#cad3f5"
        binary: "#cad3f5"
        cellpath: "#cad3f5"
        row_index: { fg: "#a6da95" attr: b }
        record: "#cad3f5"
        list: "#cad3f5"
        block: "#8aadf4"
        hints: "#5b6078"
        search_result: { fg: "#ed8796" bg: "#cad3f5" }
        shape_and: { fg: "#c6a0f6" attr: b }
        shape_binary: { fg: "#c6a0f6" attr: b }
        shape_block: { fg: "#8aadf4" attr: b }
        shape_bool: "#91d7e3"
        shape_closure: { fg: "#91d7e3" attr: b }
        shape_custom: "#a6da95"
        shape_datetime: { fg: "#91d7e3" attr: b }
        shape_directory: "#8aadf4"
        shape_external: "#8aadf4"
        shape_externalarg: { fg: "#a6da95" attr: b }
        shape_filepath: "#8aadf4"
        shape_flag: { fg: "#8aadf4" attr: b }
        shape_float: { fg: "#c6a0f6" attr: b }
        shape_garbage: { fg: "#ffffff" bg: "#ed8796" attr: b }
        shape_globpattern: { fg: "#91d7e3" attr: b }
        shape_int: { fg: "#c6a0f6" attr: b }
        shape_internalcall: { fg: "#91d7e3" attr: b }
        shape_list: { fg: "#91d7e3" attr: b }
        shape_literal: "#8aadf4"
        shape_match_pattern: "#a6da95"
        shape_matching_brackets: { attr: u }
        shape_nothing: "#91d7e3"
        shape_operator: "#eed49f"
        shape_or: { fg: "#c6a0f6" attr: b }
        shape_pipe: { fg: "#c6a0f6" attr: b }
        shape_range: { fg: "#eed49f" attr: b }
        shape_record: { fg: "#91d7e3" attr: b }
        shape_redirection: { fg: "#c6a0f6" attr: b }
        shape_signature: { fg: "#a6da95" attr: b }
        shape_string: "#a6da95"
        shape_string_interpolation: { fg: "#91d7e3" attr: b }
        shape_table: { fg: "#8aadf4" attr: b }
        shape_variable: "#c6a0f6"
        shape_vardecl: "#c6a0f6"
    }
}

# ==============================================================================
# Apply Selected Theme
# ==============================================================================

export def get_theme [] {
    let theme_name = if ($env.NU_THEME? | is-not-empty) {
        $env.NU_THEME
    } else if ($env.SMU_THEME? | is-not-empty) {
        $env.SMU_THEME
    } else {
        "gruvbox"
    }
    
    match $theme_name {
        "gruvbox" => { gruvbox_theme }
        "nord" => { nord_theme }
        "catppuccin" => { catppuccin_theme }
        "tokyo-night" => { nord_theme }
        "rose-pine" => { catppuccin_theme }
        "dracula" => { catppuccin_theme }
        "everforest" => { gruvbox_theme }
        "solarized" => { gruvbox_theme }
        "kanagawa" => { gruvbox_theme }
        _ => { 
            print $"Warning: Theme '($theme_name)' not found."
            print "Defaulting to gruvbox..."
            gruvbox_theme
        }
    }
}

# ==============================================================================
# FZF and Bat Theme Integration
# ==============================================================================
# Note: FZF and Bat theme integration happens in config.nu after module import
# to avoid parse-time issues with module-level code
