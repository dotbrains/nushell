# Nushell Plugins

This directory is for Nushell plugins and plugin-related configuration.

## What are Nushell Plugins?

Nushell plugins are executables that extend Nushell's functionality. They can add new commands, data
formats, and capabilities to your shell.

## Plugin Types

Nushell supports two types of plugins:

1. **Binary Plugins**: Compiled executables written in Rust or other languages
2. **Script Plugins**: Custom commands written in Nushell itself (stored in functions/)

## Official Plugins

Some official Nushell plugins include:

- **nu_plugin_gstat**: Git status information
- **nu_plugin_query**: Query JSON, XML, and other structured data
- **nu_plugin_inc**: Increment versions in files
- **nu_plugin_formats**: Additional data format support (SQLite, msgpack, etc.)

## Installing Plugins

### Method 1: Using Cargo (Rust package manager)

```bash
# Install from crates.io
cargo install nu_plugin_gstat

# Register the plugin with Nushell
plugin add ~/.cargo/bin/nu_plugin_gstat
```

### Method 2: Building from Source

```bash
# Clone the plugin repository
git clone https://github.com/nushell/nushell
cd nushell

# Build a specific plugin
cargo build --release -p nu_plugin_gstat

# Register it
plugin add target/release/nu_plugin_gstat
```

## Managing Plugins

### List Installed Plugins

```nushell
plugin list
```

### Add a Plugin

```nushell
plugin add /path/to/plugin/executable
```

### Remove a Plugin

```nushell
plugin rm plugin_name
```

### Update Plugin Signatures

If a plugin's signature changes, update it:

```nushell
plugin add /path/to/plugin --force
```

## Recommended Plugins

Here are some useful plugins to consider:

### nu_plugin_query

Query and transform structured data (JSON, XML, etc.).

```bash
cargo install nu_plugin_query
plugin add ~/.cargo/bin/nu_plugin_query
```

Example usage:

```nushell
open data.json | query json '.users[] | select(.name, .email)'
```

### nu_plugin_formats

Support for additional data formats like SQLite, msgpack, etc.

```bash
cargo install nu_plugin_formats
plugin add ~/.cargo/bin/nu_plugin_formats
```

Example usage:

```nushell
open database.db | query db "SELECT * FROM users"
```

### nu_plugin_gstat

Enhanced git status information.

```bash
cargo install nu_plugin_gstat
plugin add ~/.cargo/bin/nu_plugin_gstat
```

Example usage:

```nushell
gstat  # Shows detailed git repository status
```

## Creating Custom Plugins

### Using Nushell Scripts

For simpler extensions, create custom commands in `../functions/functions.nu`:

```nushell
def my-custom-command [] {
    # Your command implementation
}
```

### Using Rust

For more complex plugins, you can create a Rust binary plugin:

1. Create a new Rust project:

   ```bash
   cargo new --bin my_nu_plugin
   ```

2. Add Nushell plugin dependencies to `Cargo.toml`:

   ```toml
   [dependencies]
   nu-plugin = "0.88"
   nu-protocol = "0.88"
   ```

3. Implement the plugin interface in `src/main.rs`

4. Build and register:

   ```bash
   cargo build --release
   plugin add target/release/my_nu_plugin
   ```

## Plugin Configuration

Plugins are registered in Nushell's plugin registry file, typically located at:

- macOS/Linux: `~/.config/nushell/plugin.nu`
- Windows: `%APPDATA%\nushell\plugin.nu`

This file is automatically managed by Nushell. Don't edit it manually unless necessary.

## Troubleshooting

### Plugin Not Found

If a plugin isn't recognized:

1. Make sure it's executable:

   ```bash
   chmod +x /path/to/plugin
   ```

2. Re-register the plugin:

   ```nushell
   plugin add /path/to/plugin --force
   ```

### Plugin Signature Mismatch

If you see signature errors after updating Nushell:

```nushell
# Remove and re-add the plugin
plugin rm plugin_name
plugin add /path/to/plugin
```

### Checking Plugin Output

View plugin communication for debugging:

```nushell
plugin list | where is_running == true
```

## Resources

- [Nushell Plugin Documentation](https://www.nushell.sh/book/plugins.html)
- [Plugin Protocol](https://www.nushell.sh/contributor-book/plugins.html)
- [Community Plugins](https://github.com/nushell/awesome-nu)

## Notes

- Plugins run as separate processes for safety and isolation
- Plugin commands have the same syntax as built-in commands
- Plugins can be written in any language that can handle JSON/msgpack communication
- Binary plugins need to be recompiled when Nushell is updated to a new major version
