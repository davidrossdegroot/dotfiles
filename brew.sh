#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"
OPTIONAL_BREWFILE="$SCRIPT_DIR/Brewfile.optional"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Install it first: https://brew.sh/"
  exit 1
fi

if [[ ! -f "$BREWFILE" ]]; then
  echo "Brewfile not found at $BREWFILE"
  exit 1
fi

if [[ "${SKIP_APP_STORE:-0}" == "1" ]]; then
  export HOMEBREW_BUNDLE_MAS_SKIP="GarageBand iMovie Keynote Numbers Pages Xcode"
  echo "Skipping Mac App Store installs because SKIP_APP_STORE=1"
fi

install_optional_tools="${INSTALL_OPTIONAL_TOOLS:-0}"
subcommand="install"
if [[ $# -gt 0 ]]; then
  case "$1" in
    install|check|list|cleanup|upgrade)
      subcommand="$1"
      shift
      ;;
  esac
fi

brew_bundle_args=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --optional-tools)
      install_optional_tools="1"
      ;;
    --required-only)
      install_optional_tools="0"
      ;;
    *)
      brew_bundle_args+=("$1")
      ;;
  esac
  shift
done

# Make sure we're using the latest Homebrew metadata before installing.
brew update
brew bundle "$subcommand" --file="$BREWFILE" "${brew_bundle_args[@]}"

if [[ "$install_optional_tools" == "1" ]]; then
  if [[ ! -f "$OPTIONAL_BREWFILE" ]]; then
    echo "Optional Brewfile not found at $OPTIONAL_BREWFILE"
    exit 1
  fi

  brew bundle "$subcommand" --file="$OPTIONAL_BREWFILE" "${brew_bundle_args[@]}"
else
  echo "Skipping optional CLI extras. Re-run with --optional-tools or INSTALL_OPTIONAL_TOOLS=1 to include them."
fi

echo "Run 'nvm install --lts' after opening a new shell."
echo "If you skipped App Store installs, sign in later and rerun './brew.sh'."
if [[ "$install_optional_tools" != "1" ]]; then
  echo "Optional extras available: stow, tmux, zoxide, btop, ncdu, dockutil."
fi
