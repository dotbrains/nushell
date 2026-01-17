# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-01-17

### Added

- Comprehensive colorscheme system with gruvbox, nord, and catppuccin themes
- Modular configuration structure with separate files for aliases, functions, and variables
- Plugin documentation and examples
- Integration with modern tools: starship, zoxide, eza, mise, carapace
- Custom commands for common tasks
- Cross-platform support (macOS, Linux, BSD)

### Changed

- Use Linuxbrew to install Nushell on Linux instead of cargo
- Updated config options for Nushell 0.109+ compatibility
- Simplified test workflow to eliminate path errors

### Fixed

- Removed deprecated filesize config
- Fixed shell_integration for Nushell 0.109+
- Fixed sys command syntax
- Removed all conditional sourcing
- Fixed parse-time source errors with dynamic paths
- Fixed markdown linting issues
- Removed duplicate line_index field in explore table config
- Removed env assignment from colorscheme module

### Removed

- Deprecated configuration options incompatible with newer Nushell versions
