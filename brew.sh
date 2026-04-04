#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"

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

subcommand="install"
if [[ $# -gt 0 ]]; then
  case "$1" in
    install|check|list|cleanup|upgrade)
      subcommand="$1"
      shift
      ;;
  esac
fi

# Make sure we're using the latest Homebrew metadata before installing.
brew update
brew bundle "$subcommand" --file="$BREWFILE" "$@"

echo "Run 'nvm install --lts' after opening a new shell."
echo "If you skipped App Store installs, sign in later and rerun './brew.sh'."
