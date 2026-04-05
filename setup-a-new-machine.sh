#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Install it first: https://brew.sh/"
  exit 1
fi

subcommand="install"
if [[ $# -gt 0 ]]; then
  case "$1" in
  install | check | list | cleanup | upgrade)
    subcommand="$1"
    ;;
  esac
fi

SKIP_NVM_HINT=1 "$SCRIPT_DIR/brew.sh" "$@"

if [[ "$subcommand" == "install" || "$subcommand" == "upgrade" ]]; then
  "$SCRIPT_DIR/bin/setup-shell"
  "$SCRIPT_DIR/bin/setup-ai-coding-tools"
fi

cat <<'EOF'

Machine setup checklist:

- Change battery to show percentage
- Fix Finder sidebar and other Finder preferences
- If you installed optional tools, run `./bin/setup-dock` to recreate the Dock layout saved in this repo
- Change mouse scroll direction if needed
- Change mouse to tap to click if needed
- Download JetBrains Mono and add it in Font Book

Shell setup:

- `./setup-a-new-machine.sh` installs and updates the repo-managed shell stack: `oh-my-zsh`, `zsh-autosuggestions`, and `zsh-fzf-history-search`
- Re-run `./bin/setup-shell` any time you want to refresh that managed shell tooling without re-running the full bootstrap
- `direnv` hooks are enabled automatically in `~/.zshrc` when `direnv` is installed
- `zoxide` hooks are enabled automatically in `~/.zshrc` when optional tools are installed
- This repo expects `nvm` to use `~/.nvm`
- `./setup-a-new-machine.sh` installs the current Node LTS release through `nvm`
- Verify Node is available with `node --version` and `npm --version`
- Verify the AI coding CLIs with `codex --version` and `claude --version`
- Run `codex login` and start `claude` once to finish authentication

GitHub setup:

- Run `./bin/setup-github-auth` after this script finishes to sign in with `gh`, configure the `open` alias for `repo view --web`, let GitHub CLI create or upload an SSH key if needed, test `ssh -T git@github.com`, and switch this repo's `origin` remote from HTTPS to SSH

Repo-managed files:

- `move-in.sh` links only these files into `$HOME`: `.aliases`, `.exports`, `.extras`, `.functions`, `.gitconfig`, and `.zshrc`
- `move-in.sh` also symlinks every file in this repo's `bin/` directory into `~/bin`
- Repo docs, bootstrap scripts, and `Brewfile*` are intentionally excluded from that symlink step

Optional CLI extras:

- Re-run this script with `--optional-tools` or `INSTALL_OPTIONAL_TOOLS=1` to install `stow`, `tmux`, `zoxide`, `btop`, `ncdu`, and `dockutil`
- `dockutil` powers `./bin/capture-dock` and `./bin/setup-dock` for saving and restoring the repo's Dock layout

Postgres:

- `postgresql@16` and `libpq` are installed by default from the `Brewfile`
- `postgresql@16` is configured to start after install or upgrade through Homebrew Bundle
- Open a new shell before using `psql` or `pg_config`, since `.exports` adds Homebrew `libpq` to your `PATH`
- If you stop the service later, restart it with `brew services start postgresql@16`

Ruby references:

- https://github.com/postmodern/ruby-install
- https://github.com/postmodern/chruby
EOF
