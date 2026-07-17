ismac() { [[ "$(uname)" == "Darwin" ]]; }

# Zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Exports (early, so installers below can use ~/.local/bin)
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"

# Starship
if ! command -v starship &>/dev/null; then
    mkdir -p "$HOME/.local/bin"
    curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
fi

# Goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
if command -v goenv &>/dev/null; then
    eval "$(goenv init -)"
    export GOPATH="$HOME/go"
    export PATH="$GOROOT/bin:$PATH"
    export PATH="$PATH:$GOPATH/bin"
fi

# Claude Code
_claude_with_profile() {
  export CLAUDE_CONFIG_DIR="$1"
  command claude "${@:2}"
}

# Work profile (default)
claude() {
  _claude_with_profile "$HOME/.claude" "$@"
}

# Personal profile
pclaude() {
  (
    unset ANTHROPIC_BEDROCK_BASE_URL
    unset CLAUDE_CODE_USE_BEDROCK
    unset CLAUDE_CODE_SKIP_BEDROCK_AUTH
    export DISABLE_NON_ESSENTIAL_MODEL_CALLS=1
    export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
    _claude_with_profile "$HOME/.claude-personal" "$@"
  )
}

# Codex
_codex_with_profile() {
  export CODEX_HOME="$1"
  command codex "${@:2}"
}

# Work profile (default)
codex() {
  _codex_with_profile "$HOME/.codex" "$@"
}

# Personal profile
pcodex() {
  _codex_with_profile "$HOME/.codex-personal" "$@"
}

# Plugins

## Vi mode
ZVM_INIT_MODE=sourcing
zvm_after_init_commands+=('eval "$(starship init zsh)"')
zinit light jeffreytse/zsh-vi-mode

## Fzf
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude=.git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

## Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

## Autocompletion
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

## Autosuggestions
zinit light zsh-users/zsh-autosuggestions

## Eza- no macOS release binaries (brew provides it there), so install via
## zinit on Linux only: https://github.com/eza-community/eza/releases
if ! ismac; then
  zinit ice from"gh-r" as"program" pick"eza"
  zinit light eza-community/eza
fi

## Fzf tab
zinit light Aloxaf/fzf-tab

## Fd
zinit ice from"gh-r" as"program" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

## Ripgrep
zinit ice from"gh-r" as"program" mv"ripgrep* -> rg" pick"rg/rg"
zinit light BurntSushi/ripgrep

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

## Direnv
if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

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
export ENVIRONMENT="local"
export PIP_REQUIRE_VIRTUALENV=true
export XDG_CONFIG_HOME="$HOME/.config"

# Aliases
## Platform dependent
if ismac; then
  alias cat="bat"
else
  alias cat="batcat"
fi

## Basic
alias c="clear"
alias ede='export $(grep -v "^#" .env | xargs -0)'
alias rl="source ~/.zshrc"
alias sve="source .venv/bin/activate"

## Listing (eza if available, else plain ls)
if command -v eza &>/dev/null; then
  alias ll="eza --all --long --git --icons=always"
  alias ls="eza --all --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
  alias tree="eza --all --tree --level=2 --ignore-glob=.git"
else
  alias ll="ls -la"
  alias tree="ls -R"
fi
alias vi="nvim"
alias vim="nvim"

## Git
alias ga="git add"
alias gac="git add -A && git commit -m"
alias gb="git branch"
alias gc="git commit -m"
alias gcl="git clone"
alias gco="git checkout"
alias gl='git log --pretty="%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s" --date=short'
alias gm="git merge"
alias gpl="git pull"
alias gps="git push"
alias gri="git rebase -i"
alias grpo="git remote prune origin"
alias gst="git status -sb"
alias gsw="git switch"
alias ghd="gh dash"

## Tmux
alias tm="tmux"
alias tma="tmux attach"

# Others
alias ld="lazydocker"
alias lg="lazygit"
alias uvr="uv run"

# Source local config if it exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Disable zoxide's "doctor" advisory. It fires a false positive on every `cd`
# in non-interactive/hybrid shells (e.g. CLI-tool subprocesses) where the chpwd
# hook isn't registered; it doesn't affect directory tracking in real shells.
# https://github.com/ajeetdsouza/zoxide/issues/1208
export _ZO_DOCTOR=0
eval "$(zoxide init zsh)"
alias cd="z"
