# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Request
日本語で回答してください

## Overview

This is a personal Neovim configuration based on LazyVim, a modern Neovim starter template. The configuration is structured to provide a complete development environment with LSP, formatting, linting, and various productivity plugins.


## Architecture

### Configuration Structure
- `init.lua` - Entry point that bootstraps lazy.nvim and loads configuration
- `lua/config/` - Core configuration files:
  - `lazy.lua` - Lazy.nvim setup and plugin loading
  - `options.lua` - Neovim options and settings
  - `keymaps.lua` - Custom key mappings
  - `autocmds.lua` - Auto commands
  - `icons.lua` - Icon definitions
- `lua/plugins/` - Plugin configurations, each file configures related plugins:
  - `lsp.lua` - Language server configurations (LSP, completion, diagnostics)
  - `formatting.lua` - Code formatting with conform.nvim
  - `lint.lua` - Linting configurations
  - `colorscheme.lua` - Theme configurations
  - `editor.lua` - Editor-related plugins
  - `ui.lua` - UI enhancements
  - `coding.lua` - Coding assistance plugins
  - And many more specialized plugin files

### Key Components

**LazyVim Base**: Uses LazyVim as the foundation with solarized colorscheme
**Package Manager**: lazy.nvim for plugin management
**LSP Setup**: Mason + mason-lspconfig for language servers (PHP Intelephense, TypeScript, Lua, Python)
**Completion**: blink.cmp with ripgrep integration for file content search
**Formatting**: conform.nvim with PHP (phpcbf), JSON (jq) formatters
**Linting**: nvim-lint with phpcs, phpstan, cspell, eslint_d
**UI**: lspsaga for enhanced LSP UI, tiny-inline-diagnostic for diagnostics

## Commands

### Code Formatting
```bash
# Format is handled automatically by conform.nvim
# Format on save is typically enabled for configured file types
```

### Linting 
```bash
# Linting runs automatically on BufWritePost, InsertLeave, TextChanged
# Configured linters:
# - PHP: phpcs, phpstan, cspell
# - JavaScript/TypeScript: eslint_d, cspell
```

### Stylua (Lua formatting)
```bash
stylua .
```

### Reload Configuration
```
:source ~/.config/nvim/init.lua
# Or use the keymap: <leader>R
```

## Development Workflows

### PHP Development
- Uses Intelephense LSP server
- PHPCS linting with custom ruleset: `/Users/erikomishina/www/offerbox/public_html/phpcs_ruleset.xml`
- PHPStan static analysis with level 9
- PHPCBF formatting with the same ruleset
- Neotest with Docker PHPUnit adapter for testing

### TypeScript/JavaScript Development  
- TypeScript LSP (ts_ls) with formatting disabled (handled by conform.nvim)
- ESLint linting via eslint_d
- Currently has formatting commented out for AdminFE project

### Custom Key Mappings
- `jj` - Exit insert mode
- `cc` - Clear search highlights
- `te` - New tab
- `ss`/`sv` - Split windows
- `t` - Duplicate current line
- `<leader>r` - Replace selected text
- `<leader>R` - Reload configuration
- Special Mac option key mappings for moving lines (∆/˚)

### Plugin-Specific Features
- **Git Conflict**: Conflict resolution with `co`, `ct`, `cb`, `c0`, `]x`, `[x` 
- **Comment**: Toggle comments with `<leader>u`, block comments with `gc`
- **Dial**: Increment/decrement with `g+`/`g-`
- **WhichKey**: Help with keybindings using `<leader>`
- **LSPSaga**: Enhanced LSP UI with `gd`, `gh`, `gf`, `<leader>ca`

## File Types and Language Support

Configured for:
- **PHP**: Full LSP, linting (phpcs/phpstan), formatting (phpcbf), testing (PHPUnit)
- **JavaScript/TypeScript**: LSP, linting (eslint), optional formatting
- **Lua**: LSP (lua_ls), formatting (stylua)
- **Python**: LSP (pyright)
- **JSON**: Formatting (jq)
- **Markdown**: Enhanced with render-markdown plugin
- **PlantUML**: Preview support

## Notes

- Configuration includes Japanese comments indicating this is used by a Japanese developer
- Contains project-specific paths for PHP development (`/Users/erikomishina/www/offerbox/`)
- Uses Fish shell as default
- Mouse support is disabled (`vim.opt.mouse = ""`)
- Uses relative line numbers and keeps 30 lines of scroll offset
- Configured for dark background with solarized theme
