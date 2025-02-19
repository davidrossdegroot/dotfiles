#!/bin/bash

# Define the dotfiles directory
DOTFILES_DIR="$HOME/workspace/dotfiles"

# Ensure the dotfiles directory exists
mkdir -p "$DOTFILES_DIR"

# Prompt the user for the file path
read -p "Enter the file path relative to your HOME directory (e.g., .exports or bin/x.sh): " RELATIVE_PATH

# Expand full paths
ORIGINAL_PATH="$HOME/$RELATIVE_PATH"
TARGET_PATH="$DOTFILES_DIR/$RELATIVE_PATH"

# Check if the original file exists
if [[ ! -f "$ORIGINAL_PATH" ]]; then
  echo "Error: File does not exist at $ORIGINAL_PATH"
  exit 1
fi

# Ensure the target directory exists inside dotfiles
mkdir -p "$(dirname "$TARGET_PATH")"

# Check if the file already exists in the dotfiles directory
if [[ -f "$TARGET_PATH" ]]; then
  echo "Warning: A file already exists at $TARGET_PATH"
  read -p "Do you want to overwrite it? (y/n/cancel): " choice
  case "$choice" in
    y|Y ) rm "$TARGET_PATH"; echo "Overwriting file...";;
    n|N ) echo "Keeping existing file. Skipping move."; exit 0;;
    * ) echo "Operation canceled."; exit 1;;
  esac
fi

# Move the file
mv "$ORIGINAL_PATH" "$TARGET_PATH"

# Create the symlink
ln -s "$TARGET_PATH" "$ORIGINAL_PATH"

echo "Successfully moved $RELATIVE_PATH to $TARGET_PATH and created a symlink at $ORIGINAL_PATH"

