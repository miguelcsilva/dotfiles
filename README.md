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

### 3. Run the setup script

Installs Homebrew (if missing), all packages from the `Brewfile`, and symlinks configs to `$HOME`:

```sh
cd ~/repositories/dotfiles
./stow.sh
```

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
