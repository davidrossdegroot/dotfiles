#!/usr/bin/env bash
set -euo pipefail

# Define the dotfiles directory as the script location.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure the dotfiles directory exists
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Error: Dotfiles directory not found at $DOTFILES_DIR"
  exit 1
fi

echo "Restoring symlinks from $DOTFILES_DIR to $HOME..."

# Find all files in dotfiles repo, excluding git internals.
find "$DOTFILES_DIR" -type f \
  ! -path "$DOTFILES_DIR/.git/*" \
  ! -name ".gitignore" | while read -r FILE; do
  # Get the relative path from dotfiles directory
  RELATIVE_PATH="${FILE#"$DOTFILES_DIR"/}"
  
  # Target path in the home directory
  TARGET_PATH="$HOME/$RELATIVE_PATH"

  # Ensure the target directory exists
  mkdir -p "$(dirname "$TARGET_PATH")"

  # Skip if already linked correctly.
  if [[ -L "$TARGET_PATH" ]] && [[ "$(readlink "$TARGET_PATH")" == "$FILE" ]]; then
    echo "Already linked: $TARGET_PATH"
    continue
  fi

  # Check if the target file already exists
  if [[ -e "$TARGET_PATH" || -L "$TARGET_PATH" ]]; then
    read -r -p "File $TARGET_PATH already exists. Overwrite? (y/n/cancel): " choice
    case "$choice" in
      y|Y ) rm -rf "$TARGET_PATH"; echo "Overwriting $TARGET_PATH";;
      n|N ) echo "Skipping $TARGET_PATH"; continue;;
      * ) echo "Operation canceled."; exit 1;;
    esac
  fi

  # Create the symlink
  ln -s "$FILE" "$TARGET_PATH"
  echo "Symlinked $TARGET_PATH → $FILE"
done

echo "Symlink restoration complete!"
