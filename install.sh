#!/usr/bin/env zsh
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%F_%H%M%S)"
echo "$0"

mkdir -p "$BACKUP_DIR"

link() {
  local src="$1"
  local dst="$2"

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mv "$dst" "$BACKUP_DIR/"
  fi
  ln -s "$src" "$dst"
}

files=(.zshrc .zprofile)
for f in "${files[@]}"; do
  link "$DOTFILES_DIR/$f" "$HOME/$f"
done