# Dotfiles

Personal macOS development environment managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

| Tool | Config |
|------|--------|
| Neovim | `.config/nvim/` |
| Tmux | `.config/tmux/` |
| Kitty | `.config/kitty/` |
| Starship | `.config/starship.toml` |
| Yazi | `.config/yazi/` |
| Lazygit | `.config/lazygit/` |
| diffnav | `.config/diffnav/` |
| Zsh | `.zshrc` |
| Git | `.gitconfig` |

## Setup

### 1. Create an SSH key and add it to GitHub

```sh
ssh-keygen -t ed25519 -C "your@email.com"
cat ~/.ssh/id_ed25519.pub  # paste this into github.com/settings/keys
```

### 2. Clone the repo

```sh
git clone git@github.com:miguelcsilva/dotfiles.git ~/repositories/dotfiles
```

### 3. Run the install script

Pass `--work` or `--personal` depending on the machine. Personal installs additional apps (1Password, Google Drive, Portfolio Performance).

```sh
cd ~/repositories/dotfiles
./install.sh --work      # work machine
./install.sh --personal  # personal machine
```

This will:
- Install Homebrew if missing
- Install all packages from `Brewfile` (common to both modes)
- Install personal-only packages from `Brewfile.personal` (personal mode only)
- Install the latest Go version via goenv and set it as global
- Install/upgrade the `gh-dash` GitHub CLI extension
- Symlink all configs to `$HOME` via stow

> To re-symlink configs without reinstalling packages, run `./stow.sh` directly.

### 4. Configure git identity

Create `~/.gitconfig.private` (not tracked by git) with your default identity:

```sh
cp ~/.gitconfig.private.example ~/.gitconfig.private
```

Optionally, create per-directory overrides for different identities:

```sh
cp ~/.gitconfig.private.example ~/.gitconfig.private.personal
cp ~/.gitconfig.private.example ~/.gitconfig.private.work
```

These are picked up automatically based on where the repo lives:

- `~/personal/` → `.gitconfig.private.personal`
- `~/work/` → `.gitconfig.private.work`
