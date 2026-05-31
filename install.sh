#!/usr/bin/env zsh
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%F_%H%M%S)"
PACKAGES=(
  zsh
  git
  tmux
  codex
)

echo "Installing dotfiles from: $DOTFILES_DIR"

if ! command -v stow >/dev/null 2>&1; then
  echo "Error: GNU Stow is not installed. Run ./bootstrap.sh first." >&2
  exit 1
fi

typeset -i backed_up=0
typeset -i already_linked=0

backup_stow_conflicts() {
  local package="$1"

  if [ ! -d "$DOTFILES_DIR/$package" ]; then
    echo "Error: stow package does not exist: $DOTFILES_DIR/$package" >&2
    exit 1
  fi

  while IFS= read -r -d '' src; do
    local rel="${src#$DOTFILES_DIR/$package/}"
    local dst="$HOME/$rel"

    if [ -L "$dst" ] && [ "${dst:A}" = "${src:A}" ]; then
      ((already_linked += 1))
      continue
    fi

    if [ -e "$dst" ] || [ -L "$dst" ]; then
      local backup="$BACKUP_DIR/$rel"
      mkdir -p "${backup:h}"
      mv "$dst" "$backup"
      ((backed_up += 1))
    fi
  done < <(find "$DOTFILES_DIR/$package" -type f -print0)
}

for package in "${PACKAGES[@]}"; do
  backup_stow_conflicts "$package"
done

cd "$DOTFILES_DIR"
stow --no-folding --target="$HOME" "${PACKAGES[@]}"

if (( backed_up == 0 )); then
  rmdir "$BACKUP_DIR" 2>/dev/null || true
fi

echo

echo "Install summary"
echo "- Packages:         ${PACKAGES[*]}"
echo "- Already linked:   $already_linked"
echo "- Backed up:        $backed_up"

if (( backed_up > 0 )); then
  echo "- Backup directory:    $BACKUP_DIR"
fi
