#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Install it first: https://brew.sh/"
  exit 1
fi

"$SCRIPT_DIR/brew.sh" "$@"

cat <<'EOF'

Machine setup checklist:

- Change battery to show percentage
- Fix Finder sidebar and other Finder preferences
- Remove apps from the Dock that you do not use
- Change mouse scroll direction if needed
- Change mouse to tap to click if needed
- Download JetBrains Mono and add it in Font Book

Shell setup:

- Install oh-my-zsh: sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
- Install the zsh plugins you want, for example `zsh-autosuggestions`
- Open a new shell and run `nvm install --lts`

Repo-managed files:

- Review `move-in.sh` before running it. It is still broad and will symlink repo files into `$HOME`.
- Copy helper scripts into `~/bin` if you want them available on your PATH: `mkdir -p ~/bin && cp bin/* ~/bin/`

Postgres:

- `postgresql@16` and `libpq` are installed by default from the `Brewfile`
- `postgresql@16` is configured to start after install or upgrade through Homebrew Bundle
- Open a new shell before using `psql` or `pg_config`, since `.exports` adds Homebrew `libpq` to your `PATH`
- If you stop the service later, restart it with `brew services start postgresql@16`

Ruby references:

- https://github.com/postmodern/ruby-install
- https://github.com/postmodern/chruby
EOF
