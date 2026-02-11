#!/usr/bin/env zsh
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%F_%H%M%S)"

echo "Installing dotfiles from: $DOTFILES_DIR"
mkdir -p "$BACKUP_DIR"

typeset -i total=0
typeset -i skipped=0
typeset -i backed_up=0
typeset -i linked=0
typeset -i created=0
typeset -i relinked=0
typeset -i optional_missing=0

link_required() {
  local src="$1"
  local dst="$2"
  local had_existing=0

  if [ ! -e "$src" ]; then
    echo "Error: required source file does not exist: $src" >&2
    exit 1
  fi

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    ((skipped += 1))
    return
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mv "$dst" "$BACKUP_DIR/"
    ((backed_up += 1))
    had_existing=1
  fi

  ln -s "$src" "$dst"
  ((linked += 1))
  if (( had_existing )); then
    ((relinked += 1))
  else
    ((created += 1))
  fi
}

link_optional() {
  local src="$1"
  local dst="$2"

  if [ ! -e "$src" ]; then
    ((optional_missing += 1))
    return
  fi

  link_required "$src" "$dst"
}

required_files=(
  # zsh
  zsh/.zshrc
  zsh/.zprofile
  zsh/aliases.zsh
  # git
  git/.gitconfig
  git/.gitignore_global
)

optional_files=(
  # local-only file, if you choose to keep one in repo
  zsh/.zshrc.local
)

for f in "${required_files[@]}"; do
  ((total += 1))
  link_required "$DOTFILES_DIR/$f" "$HOME/${f:t}"
done

for f in "${optional_files[@]}"; do
  ((total += 1))
  link_optional "$DOTFILES_DIR/$f" "$HOME/${f:t}"
done

if (( backed_up == 0 )); then
  rmdir "$BACKUP_DIR" 2>/dev/null || true
fi

echo

echo "Install summary"
echo "- Total:            $total"
echo "- Changed:          $linked"
echo "  - New links:      $created"
echo "  - Relinked:       $relinked"
echo "- Already linked:   $skipped"
echo "- Backed up:        $backed_up"
echo "- Optional missing: $optional_missing"

if (( backed_up > 0 )); then
  echo "- Backup directory:    $BACKUP_DIR"
fi
