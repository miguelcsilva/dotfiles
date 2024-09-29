# Dotfiles

A collection of dotfiles for easy setup and configurations of Linux distributions.

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
stow . -t ~/
```
### 5. Configure the `~/.gitconfig.private` files
```
cp ~/.gitconfig.private.example ~/.gitconfig.private.personal
cp ~/.gitconfig.private.example ~/.gitconfig.private.work
```
