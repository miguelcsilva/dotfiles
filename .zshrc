ismac(){
  if [[ "$(uname)" == "Darwin" ]]; then
    return true
  else
    return false
  fi
}

# Zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Starship
if [ ! -e /usr/local/bin/starship ]; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
eval "$(starship init zsh)"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Plugins

## Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

## Autocompletion
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

## Autosuggestions
zinit light zsh-users/zsh-autosuggestions

## Fzf
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude=.git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

## Eza- cannot be installed with zinit since they don't release macos binaries: https://github.com/eza-community/eza/releases

## Fzf tab
zinit light Aloxaf/fzf-tab

## Fd
zinit ice from"gh-r" as"program" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

## Delta
zinit ice from"gh-r" as"program" mv"delta* -> delta" pick"delta/delta"
zinit light dandavison/delta

## Bat
zinit ice from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat
if [ ! -f "$HOME/.config/bat/themes/tokyonight_moon.tmTheme" ]; then
    curl --create-dirs --output "$HOME/.config/bat/themes/tokyonight_moon.tmTheme" https://raw.githubusercontent.com/folke/tokyonight.nvim/refs/heads/main/extras/sublime/tokyonight_moon.tmTheme
    bat cache --build
fi
export BAT_THEME="tokyonight_moon"

## Zoxide
zinit ice from"gh-r" as"program"
zinit light ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# Keybindings
bindkey '^y' autosuggest-accept

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':fzf-tab:complete:z:*'  fzf-preview 'eza --all --long --git --no-filesize --icons=always --no-time --no-user --no-permissions $realpath'
zstyle ':fzf-tab:complete:eza:*'  fzf-preview 'eza --all --long --git --no-filesize --icons=always --no-time --no-user --no-permissions $realpath'
zstyle ':fzf-tab:complete:bat:*'  fzf-preview 'bat $realpath'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory

# Exports
export PATH="$HOME/.local/bin:$PATH"
export POETRY_CONFIG_DIR="$HOME/.config/pypoetry"

# Aliases
## Platform dependent
if ismac; then
  alias cat="bat"
else
  alias cat="batcat"
fi

## Basic
alias c="clear"
alias cd="z"
alias ls="eza --all --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ll="eza --all --long --git --icons=always"
alias rl="source ~/.zshrc"
alias sve="source .venv/bin/activate"
alias ede='export $(grep -v "^#" .env | xargs -0)'
alias tree="eza --all --tree --level=2 --ignore-glob=.git"
alias vim="nvim"

## Git
alias ga="git add"
alias gb="git branch"
alias gc="git commit -m"
alias gac="git add -A && git commit -m"
alias gcl="git clone"
alias gco="git checkout"
alias gm="git merge"
alias gl='git log --pretty="%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s" --date=short'
alias gpl="git pull"
alias gps="git push"
alias gri="git rebase -i"
alias grpo="git remote prune origin"
alias gst="git status -sb"
alias gsw="git switch"
