# AGENTS.md - Dotfiles Repository

This is a personal dotfiles repository for easy setup and configuration of development environments across macOS and omarchy (Linux).

## Repository Structure

- **`common/`** - Shared configs deployed on all machines:
  - `.zshrc` - Zsh shell configuration
  - `.gitconfig` - Git configuration
  - `.vimrc` - Vim configuration (legacy)
  - `.config/nvim/` - Neovim configuration (Lua-based)
  - `.config/tmux/` - Tmux configuration
  - `.config/kitty/` - Kitty terminal emulator (base config)
  - `.config/starship.toml` - Starship prompt
  - `.config/lazygit/` - LazyGit TUI
  - `.config/yazi/` - Yazi file manager
  - `.config/diffnav/` - DiffNav configuration

- **`macos/`** - macOS-specific configs:
  - `.config/kitty/os.conf` - macOS kitty overrides (font size, etc.)

- **`omarchy/`** - omarchy/Linux-specific configs:
  - `.agents/` - Shared agent commands, skills, and settings
  - `.claude/` - Claude Code config (symlinks to .agents)
  - `.codex/` - Codex config (symlinks to .agents)
  - `.config/kitty/os.conf` - omarchy kitty overrides
  - `.config/omarchy/hooks/` - omarchy post-update hooks

- **Root files** (not stowed):
  - `stow.sh` - Setup script (auto-detects OS)
  - `.gitconfig.private.example` - Template for private Git settings
  - `stylua.toml` - Lua code formatter configuration
  - `.pre-commit-config.yaml` - Pre-commit hooks

## Setup Mechanism

Uses GNU Stow with multi-package support. `stow.sh` detects the OS and stows `common/` plus the appropriate OS package (`macos/` or `omarchy/`).

## Neovim Configuration

The Neovim setup is modern and Lua-based:
- **Entry Point:** `common/.config/nvim/init.lua`
- **Structure:** Modular configuration split into:
  - `lua/config/` - Core configuration (keymaps, options, pack)
  - `plugin/` - Plugin-specific configurations

### Key Plugins Configured:
- **LSP:** Language Server Protocol setup
- **FZF:** Fuzzy finder (fzf-lua)
- **Git:** Git integration (gitsigns, diffview)
- **Completion:** blink.cmp
- **Which-key:** Keybinding helper
- **Flash:** Enhanced navigation
- **Statusline:** lualine
- **Treesitter:** Syntax highlighting
- **DAP:** Debugging
- **Indent:** hlchunk

## Common Commands

For linting and formatting:
- `stylua` - Format Lua files (configured via stylua.toml)
- `pre-commit run --all-files` - Run all pre-commit hooks

## Notes for Agents

- This is a dotfiles repository focused on development environment setup
- Primary editor is Neovim with extensive Lua configuration
- Uses modern development tools (Starship, LazyGit, Yazi, etc.)
- Configuration is modular and well-organized
- Private configurations are handled via separate files (not tracked in Git)
- OS-specific configs are separated into `macos/` and `omarchy/` stow packages
