# configurations
source ~/.zsh/.completion
source ~/.zsh/.prompt

# zsh
ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# aliases - basic
alias c="clear"
alias ls="ls --color=auto"
alias ll="ls -la"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias sve="source .venv/bin/activate"

# aliases - git
alias ga="git add"
alias gb="git branch"
alias gc="git commit -m"
alias gac="git add -A && git commit -m"
alias gcl="git clone"
alias gco="git checkout"
alias gl='git log --pretty="%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s" --date=short'
alias gpl="git pull"
alias gps="git push"
alias grpo="git remote prune origin"
alias gst="git status -sb"
alias gsw="git switch"


# poetry
export PATH="$HOME/.local/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
