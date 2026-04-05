# Dotfiles

A collection of dotfiles for easy setup and configuration of development environments across macOS and omarchy (Linux).

## Structure

- `common/` - Shared configs deployed on all machines (nvim, tmux, zsh, kitty, starship, git, etc.)
- `macos/` - macOS-specific configs
- `omarchy/` - omarchy/Linux-specific configs (including agent skills for Claude and Codex)

Uses [GNU Stow](https://www.gnu.org/software/stow/) with multi-package support to symlink the right configs per OS.

## Usage

### 1. Create SSH keys
```
 ssh-keygen -t rsa -b 4096
```
### 2. Add SSH key to GitHub account
### 3. Clone the repository
```
git clone git@github.com:miguelcsilva/dotfiles.git
```
### 4. Navigate to the repo and create the symlinks to the home directory
```
cd path/to/repository
./stow.sh
```
### 5. Configure the `~/.gitconfig.private` files
```
cp ~/.gitconfig.private.example ~/.gitconfig.private.personal
cp ~/.gitconfig.private.example ~/.gitconfig.private.work
```
