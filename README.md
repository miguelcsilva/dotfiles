# Dotfiles

A collection of dotfiles for easy setup and configurations of Linux distributions.

## Usage

### 1. Create SSH keys
```
ssh-keygen -b 2048
```
### 2. Add SSH key to GitHub account
### 3. Clone the repository
```
git clone git@github.com:miguelcsilva/dotfiles.git
```
### 4. Install stow
```
sudo apt install stow
```
### 5. Navigate to the repo and create the symlinks to the home directory.
```
cd ~/repos/dotfiles
stow . -t ~/
```
### 5. Configure the `~/.gitconfig.private` file
```
cp ~/.gitconfig.private.example ~/.gitconfig.private
vim ~/.gitconfig.private
```
