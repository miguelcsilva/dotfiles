#!/bin/bash
set -euo pipefail

STOW_ARGS=(--target="$HOME" --restow .)

if [[ "${MACHINE_PROFILE:-}" == "work" ]]; then
    STOW_ARGS+=(--ignore='\.claude/commands' --ignore='\.claude/skills')
fi

stow "${STOW_ARGS[@]}"
