#!/usr/bin/env zsh
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%F_%H%M%S)"

echo "Installing dotfiles from: $DOTFILES_DIR"
mkdir -p "$BACKUP_DIR"

echo "Backup directory: $BACKUP_DIR"

link() {
  local src="$1"
  local dst="$2"

  if [ ! -e "$src" ]; then
    echo "Error: source file does not exist: $src"
    exit 1
  fi

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "Skip (already linked): $dst -> $src"
    return
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mv "$dst" "$BACKUP_DIR/"
    echo "Backed up: $dst"
  fi

  ln -s "$src" "$dst"
  echo "Linked: $dst -> $src"
}

files=(
  zsh/.zshrc
  zsh/.zprofile
  zsh/aliases.zsh
  zsh/.zshrc.local
  git/.gitconfig
  git/.gitignore_global
)

for f in "${files[@]}"; do
  link "$DOTFILES_DIR/$f" "$HOME/${f:t}"
done
