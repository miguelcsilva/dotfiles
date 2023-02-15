# prompt
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%b'
precmd(){
	vcs_info
	local preprompt_left="%F{#96ceb4}%n@%F{#ffeead}%m:%F{#ff6f69}%(3~|%-1~/.../%1~|%2~) %F{#ffcc5c}on ${vcs_info_msg_0_}"
	local preprompt_right="%F{#88d8b0}$(date +'%T')"
	local preprompt_left_length=${#${(S%%)preprompt_left//(\%([KF1]|)\{*\}|\%[Bbkf])}}
	local preprompt_right_length=${#${(S%%)preprompt_right//(\%([KF1]|)\{*\}|\%[Bbkf])}}
	local num_filler_spaces=$((COLUMNS - preprompt_left_length - preprompt_right_length))
	print -Pr $'\n'"$preprompt_left${(l:$num_filler_spaces:)}$preprompt_right"
}

PROMPT="$ "

# zsh
ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# aliases
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

alias ll="ls -la"

# poetry
export PATH="/home/miguelsilva/.local/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
