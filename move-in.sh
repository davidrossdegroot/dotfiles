#!/usr/bin/env bash
set -euo pipefail

# Define the dotfiles directory as the script location.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Only link the files this repo intentionally manages in $HOME.
MANAGED_HOME_FILES=(
  ".aliases"
  ".exports"
  ".extras"
  ".functions"
  ".gitconfig"
  ".zshrc"
)

# Ensure the dotfiles directory exists
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Error: Dotfiles directory not found at $DOTFILES_DIR"
  exit 1
fi

echo "Restoring managed symlinks from $DOTFILES_DIR to $HOME..."

link_managed_path() {
  local RELATIVE_PATH="$1"
  local FILE="$DOTFILES_DIR/$RELATIVE_PATH"
  local TARGET_PATH

  if [[ ! -e "$FILE" ]]; then
    echo "Skipping missing managed file: $FILE"
    return
  fi

  # Target path in the home directory
  TARGET_PATH="$HOME/$RELATIVE_PATH"

  # Ensure the target directory exists
  mkdir -p "$(dirname "$TARGET_PATH")"

  # Skip if already linked correctly.
  if [[ -L "$TARGET_PATH" ]] && [[ "$(readlink "$TARGET_PATH")" == "$FILE" ]]; then
    echo "Already linked: $TARGET_PATH"
    return
  fi

  # Check if the target file already exists
  if [[ -e "$TARGET_PATH" || -L "$TARGET_PATH" ]]; then
    read -r -p "File $TARGET_PATH already exists. Overwrite? (y/n/cancel): " choice
    case "$choice" in
    y | Y)
      rm -rf -- "$TARGET_PATH"
      echo "Overwriting $TARGET_PATH"
      ;;
    n | N)
      echo "Skipping $TARGET_PATH"
      return
      ;;
    *)
      echo "Operation canceled."
      exit 1
      ;;
    esac
  fi

  # Create the symlink
  ln -s "$FILE" "$TARGET_PATH"
  echo "Symlinked $TARGET_PATH -> $FILE"
}

for RELATIVE_PATH in "${MANAGED_HOME_FILES[@]}"; do
  link_managed_path "$RELATIVE_PATH"
done

if [[ -d "$DOTFILES_DIR/bin" ]]; then
  shopt -s nullglob
  for FILE in "$DOTFILES_DIR"/bin/*; do
    [[ -f "$FILE" ]] || continue
    link_managed_path "${FILE#"$DOTFILES_DIR"/}"
  done
  shopt -u nullglob
fi

echo "Symlink restoration complete!"
