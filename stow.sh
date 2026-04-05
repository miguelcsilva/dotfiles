#!/bin/bash
set -euo pipefail

PACKAGES=(common)

if [[ "$(uname)" == "Darwin" ]]; then
    PACKAGES+=(macos)
else
    PACKAGES+=(omarchy)
fi

stow --target="$HOME" --restow "${PACKAGES[@]}"
