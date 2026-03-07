#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Install it first: https://brew.sh/"
  exit 1
fi

# Make sure we're using the latest Homebrew.
brew update
brew upgrade

# Core CLI tools.
formulas=(
  coreutils
  moreutils
  findutils
  gnu-sed
  bash
  bash-completion
  wget
  vim
  nano
  grep
  z
  mtr
  fzf
  git
  imagemagick
  tree
  nvm
  zsh
)

for formula in "${formulas[@]}"; do
  brew install "$formula"
done

# GUI apps.
casks=(
  1password
  iterm2
  sublime-text
  gyazo
  spectacle
  visual-studio-code
)

for cask in "${casks[@]}"; do
  brew install --cask "$cask"
done

echo "Run 'nvm install --lts' after opening a new shell."

# Remove outdated versions from the cellar.
brew cleanup
