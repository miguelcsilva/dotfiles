# configurations
source ~/.zsh/.completion
source ~/.zsh/.prompt

# zsh
ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# Aliases
## Basic
alias c="clear"
alias ls="ls --color=auto"
alias ll="ls -la"
alias sve="source .venv/bin/activate"
alias rl="source ~/.zshrc"

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

# Key remap
bindkey "sb" history-incremental-search-backward

## Essential tools
### Tree
alias tr="tree -a -L 1 -C"
### Bat
alias cat="batcat"
### Zoxide
eval "$(zoxide init zsh)"
alias cd="z"
alias zz="z -"

# Poetry
export PATH="$HOME/.local/bin:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
