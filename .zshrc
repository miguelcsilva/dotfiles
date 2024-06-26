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
## Fuzzy finder
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf
eval "$(fzf --zsh)"
zinit light Aloxaf/fzf-tab
## Zoxide
zinit ice from"gh-r" as"program"
zinit light ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# Keybindings
bindkey '^ ' autosuggest-accept

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory

# Aliases
## Basic
alias c="clear"
alias cat="batcat"
alias cd="z"
alias ls="ls --color=auto"
alias ll="ls -lha"
alias rl="source ~/.zshrc"
alias sve="source .venv/bin/activate"
alias tree="tree -C"

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