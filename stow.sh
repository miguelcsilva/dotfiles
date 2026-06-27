#!/bin/bash
set -euo pipefail

stow --target="$HOME" --restow --dir="$(dirname "$0")" .
