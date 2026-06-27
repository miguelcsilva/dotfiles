#!/bin/bash
set -euo pipefail

usage() {
    echo "Usage: $0 [--work | --personal]"
    exit 1
}

MODE=""
case "${1:-}" in
    --work)     MODE="work" ;;
    --personal) MODE="personal" ;;
    *)          usage ;;
esac

DIR="$(dirname "$0")"

if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

HOMEBREW_BUNDLE_CASK_INSTALL_FLAGS="--adopt" brew bundle install --file="$DIR/Brewfile"

if [[ "$MODE" == "personal" ]]; then
    HOMEBREW_BUNDLE_CASK_INSTALL_FLAGS="--adopt" brew bundle install --file="$DIR/Brewfile.personal"
fi

COMBINED_BREWFILE=$(mktemp)
trap 'rm -f "$COMBINED_BREWFILE"' EXIT
cat "$DIR/Brewfile" > "$COMBINED_BREWFILE"
[[ "$MODE" == "personal" ]] && cat "$DIR/Brewfile.personal" >> "$COMBINED_BREWFILE"
brew bundle cleanup --force --file="$COMBINED_BREWFILE"

if ! go version &>/dev/null; then
    LATEST_GO=$(goenv install --list | grep -E '^\s*[0-9]+\.[0-9]+\.[0-9]+$' | tail -1 | tr -d ' ')
    echo "y" | goenv install "$LATEST_GO"
    goenv use "$LATEST_GO" --global
fi

gh extension install dlvhdr/gh-dash 2>/dev/null || gh extension upgrade gh-dash 2>/dev/null || true

"$DIR/stow.sh"
