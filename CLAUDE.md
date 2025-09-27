# CLAUDE.md - Dotfiles Repository

This is a personal dotfiles repository for easy setup and configuration of development environments, primarily focused on Neovim, shell configuration, and various development tools.

## Repository Structure

- **Root Configuration Files:**
  - `.gitconfig` - Git configuration
  - `.gitconfig.private.example` - Template for private Git settings
  - `.tmux.conf` - Tmux configuration
  - `.vimrc` - Vim configuration (legacy)
  - `.zshrc` - Zsh shell configuration
  - `stylua.toml` - Lua code formatter configuration

- **Configuration Directory (`.config/`):**
  - `nvim/` - Neovim configuration with Lua-based setup
  - `kitty/` - Kitty terminal emulator configuration
  - `lazygit/` - LazyGit TUI configuration
  - `pypoetry/` - Python Poetry configuration
  - `starship.toml` - Starship prompt configuration
  - `yazi/` - Yazi file manager configuration

## Neovim Configuration

The Neovim setup is modern and Lua-based:
- **Entry Point:** `.config/nvim/init.lua`
- **Structure:** Modular configuration split into:
  - `config/` - Core configuration (keymaps, options, lazy plugin manager)
  - `plugins/` - Plugin-specific configurations

### Key Plugins Configured:
- **LSP:** Language Server Protocol setup
- **FZF:** Fuzzy finder (fzf-lua)
- **Git:** Git integration
- **Theme:** Color scheme configuration
- **File Manager:** File navigation
- **Which-key:** Keybinding helper
- **Flash:** Enhanced navigation
- **Statusline:** Status line customization
- **Noice:** UI enhancements
- **Markdown:** Markdown support
- **Indent:** Indentation visualization
- **Starter:** Start screen

## Development Tools

- **Pre-commit hooks:** Configured with various checks including StyLua formatting
- **Version Control:** Git with separate work/personal configurations

## Common Commands

For linting and formatting:
- `stylua` - Format Lua files (configured via stylua.toml)
- `pre-commit run --all-files` - Run all pre-commit hooks

## Notes for Claude

- This is a dotfiles repository focused on development environment setup
- Primary editor is Neovim with extensive Lua configuration
- Uses modern development tools (Starship, LazyGit, Yazi, etc.)
- Configuration is modular and well-organized
- Private configurations are handled via separate files (not tracked in Git)
