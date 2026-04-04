#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"
OPTIONAL_BREWFILE="$SCRIPT_DIR/Brewfile.optional"

append_bundle_skip_values() {
  local env_var_name="$1"
  shift

  local current_value="${!env_var_name:-}"
  local value

  for value in "$@"; do
    [[ -n "$value" ]] || continue
    if [[ -n "$current_value" ]]; then
      current_value+=" "
    fi
    current_value+="$value"
  done

  printf -v "$env_var_name" '%s' "$current_value"
  # shellcheck disable=SC2163
  export "$env_var_name"
}

skip_casks_for_brewfile() {
  local brewfile_path="$1"
  local -a casks=()
  local line

  [[ "${SKIP_CASKS:-0}" == "1" ]] || return
  [[ -f "$brewfile_path" ]] || return

  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ ^[[:space:]]*cask[[:space:]]+\"([^\"]+)\" ]]; then
      casks+=("${BASH_REMATCH[1]}")
    fi
  done <"$brewfile_path"

  [[ ${#casks[@]} -gt 0 ]] || return

  append_bundle_skip_values HOMEBREW_BUNDLE_CASK_SKIP "${casks[@]}"
  echo "Skipping Homebrew cask installs from $(basename "$brewfile_path") because SKIP_CASKS=1"
}

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

skip_casks_for_brewfile "$BREWFILE"

install_optional_tools="${INSTALL_OPTIONAL_TOOLS:-0}"
subcommand="install"
if [[ $# -gt 0 ]]; then
  case "$1" in
  install | check | list | cleanup | upgrade)
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

run_brew_bundle() {
  local brewfile_path="$1"

  if [[ ${#brew_bundle_args[@]} -gt 0 ]]; then
    brew bundle "$subcommand" --file="$brewfile_path" "${brew_bundle_args[@]}"
  else
    brew bundle "$subcommand" --file="$brewfile_path"
  fi
}

if [[ "${SKIP_BREW_UPDATE:-0}" == "1" ]]; then
  echo "Skipping brew update because SKIP_BREW_UPDATE=1"
else
  # Make sure we're using the latest Homebrew metadata before installing.
  brew update
fi

run_brew_bundle "$BREWFILE"

if [[ "$install_optional_tools" == "1" ]]; then
  if [[ ! -f "$OPTIONAL_BREWFILE" ]]; then
    echo "Optional Brewfile not found at $OPTIONAL_BREWFILE"
    exit 1
  fi

  skip_casks_for_brewfile "$OPTIONAL_BREWFILE"
  run_brew_bundle "$OPTIONAL_BREWFILE"
else
  echo "Skipping optional CLI extras. Re-run with --optional-tools or INSTALL_OPTIONAL_TOOLS=1 to include them."
fi

echo "Run 'nvm install --lts' after opening a new shell."
echo "If you skipped App Store installs, sign in later and rerun './brew.sh'."
if [[ "$install_optional_tools" != "1" ]]; then
  echo "Optional extras available: stow, tmux, zoxide, btop, ncdu, dockutil."
fi
