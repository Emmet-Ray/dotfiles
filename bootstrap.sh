#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Error: Homebrew is not installed. Install Homebrew first: https://brew.sh/"
  exit 1
fi

# Core tools used by zsh config and aliases.
brew install zoxide fzf eza bat zsh-syntax-highlighting zsh-autosuggestions
