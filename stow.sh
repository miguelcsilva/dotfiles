#!/bin/bash
set -euo pipefail

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle install --file="$(dirname "$0")/Brewfile"

gh extension install dlvhdr/gh-dash 2>/dev/null || gh extension upgrade gh-dash 2>/dev/null || true

stow --target="$HOME" --restow --dir="$(dirname "$0")" .
