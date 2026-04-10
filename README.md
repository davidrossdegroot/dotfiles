# dotfiles

Used this for a MacBook Air in 2020 and a Mac mini in February 2025.

## Canonical bootstrap flow

1. Install Xcode Command Line Tools:

```bash
xcode-select --install
```

2. Install Homebrew.
3. Clone this repo over HTTPS.
4. Sign in to the Mac App Store if you want `mas` to install App Store apps.
5. Run:

```bash
./setup-a-new-machine.sh
```

If you also want the optional CLI extras (`stow`, `tmux`, `zoxide`, `btop`, `ncdu`, and `dockutil`), use:

```bash
INSTALL_OPTIONAL_TOOLS=1 ./setup-a-new-machine.sh
```

If you are not signed in to the App Store yet, you can skip those installs for now:

```bash
SKIP_APP_STORE=1 ./setup-a-new-machine.sh
```

6. Run:

```bash
./script/setup-github-auth
```

That helper uses `gh` to authenticate GitHub in the browser, set GitHub's preferred git protocol to SSH, add an `open` alias for `repo view --web`, prompt to create or upload an SSH key when needed, test `ssh -T git@github.com`, and switch this repo's `origin` remote from HTTPS to SSH.

Cloning over HTTPS keeps SSH setup out of the critical path for a fresh machine. If the repo is private, use whatever HTTPS auth flow gets the first clone onto disk, then switch the machine to SSH with `./script/setup-github-auth`.

The package source of truth is `Brewfile` for the default bootstrap and `Brewfile.optional` for opt-in extras. `setup-a-new-machine.sh` is the human-friendly entrypoint, and `brew.sh` is the package-only helper that runs `brew bundle`.

The shell toolchain that this repo expects is also managed during bootstrap. `./setup-a-new-machine.sh` installs or updates `oh-my-zsh`, `zsh-autosuggestions`, and `zsh-fzf-history-search` through `./script/setup-shell`, so the default shell path is explicit instead of manual.

This bootstrap assumes macOS or Xcode Command Line Tools already provide:

- `bash`
- `git`
- `zsh`

Those are intentionally not installed from Homebrew.

## Which Script Does What

`./setup-a-new-machine.sh` is the software bootstrap step for a new Mac. It runs `./brew.sh`, which runs `brew bundle` against `Brewfile` to install the default CLI tools, casks, and optional Mac App Store apps. That includes the `claude-code` cask for Claude Code. After that, it runs `./script/setup-shell` to install or update the repo-managed Zsh stack, then uses Homebrew `nvm` to install the current Node LTS release and installs the Codex CLI globally with npm through `./script/setup-ai-coding-tools`. Pass `--optional-tools` or set `INSTALL_OPTIONAL_TOOLS=1` to also install the extras from `Brewfile.optional`. It does not symlink repo files into `$HOME`.

`./script/setup-shell` is the shell bootstrap helper. It installs or updates `oh-my-zsh`, `zsh-autosuggestions`, and `zsh-fzf-history-search` in the standard Oh My Zsh locations without overwriting the repo-managed `~/.zshrc`. Re-run it whenever you want to refresh those shell dependencies outside the full machine bootstrap.

`./script/setup-ai-coding-tools` installs the current Node LTS release through Homebrew `nvm`, then installs the Codex CLI globally with npm.

`./script/setup-github-auth` is the GitHub auth step after bootstrap. It uses the installed GitHub CLI to sign in with `--git-protocol ssh`, configures the `open` alias for `repo view --web`, lets GitHub CLI create or upload an SSH key if needed, tests the SSH connection to GitHub, and switches this repo's `origin` remote from HTTPS to SSH.

`./script/setup-dock` is the repo-only Dock restore helper. It uses `dockutil` to recreate the Dock from `dock/layout.sh` when you want this repo's saved Dock layout on a machine.

`./move-in.sh` is the dotfile linking step. It creates symlinks for the small set of home-directory config files this repo intentionally manages, and it symlinks the intentionally user-facing helpers from `bin/` into `~/bin`. It does not install Homebrew packages, casks, or App Store apps.

If you are setting up a fresh machine, the intended order is:

1. Clone the repo over HTTPS so SSH setup does not block bootstrap.
2. Run `./setup-a-new-machine.sh` to install software, including `gh`.
3. Run `./script/setup-github-auth` to authenticate GitHub and switch this repo to SSH.
4. If you installed optional tools and want this repo's Dock layout, run `./script/setup-dock`.
5. Review `./move-in.sh`, then run it if you want the managed dotfiles linked into `$HOME` and the repo's `bin/*` helpers symlinked into `~/bin`.

## What Gets Installed

Package installs are managed through `brew bundle` and include:

- Homebrew formulae from `Brewfile`
- Optional Homebrew formulae from `Brewfile.optional` when `--optional-tools` or `INSTALL_OPTIONAL_TOOLS=1` is used
- GUI apps through Homebrew Cask
- Mac App Store apps through `mas`

`./setup-a-new-machine.sh` also installs:

- `oh-my-zsh` in `~/.oh-my-zsh`
- `zsh-autosuggestions` in `~/.oh-my-zsh/custom/plugins/zsh-autosuggestions`
- `zsh-fzf-history-search` in `~/.oh-my-zsh/custom/plugins/zsh-fzf-history-search`
- the current Node LTS release through Homebrew `nvm`
- `@openai/codex` as the `codex` CLI after Node is installed

Required/default formulae now include the core Unix tooling this repo expects on every machine:

- `bat` for syntax-highlighted file previews
- `direnv` for automatically loading per-project environment variables from `.envrc`
- `fd` for fast file and directory discovery
- `gh` for GitHub workflows from the terminal
- `jq` for querying and transforming JSON
- `ripgrep` for fast recursive text search with `rg`
- `shellcheck` for linting shell scripts
- `shfmt` for formatting shell scripts

The default formula list also includes local Postgres support through:

- `postgresql@16` for a local Postgres server
- `libpq` for client tools such as `psql` and `pg_config`

Optional CLI extras are kept separate so the default bootstrap stays lean:

- `btop` for an interactive system monitor
- `dockutil` for scripting Dock changes
- `ncdu` for browsing disk usage from the terminal
- `stow` for managing symlink-based dotfiles layouts
- `tmux` for persistent terminal sessions and panes
- `zoxide` for smarter directory jumping based on where you use `cd`

This repo still uses `./move-in.sh` for its curated symlink flow, so `stow` is installed only as an extra tool rather than replacing that script outright.

Notable cask installs include:

- `1password`
- `claude`
- `claude-code`
- `google-chrome`
- `iterm2`
- `sublime-text`
- `visual-studio-code`

Managed App Store installs currently include:

- `GarageBand`
- `iMovie`
- `Keynote`
- `Numbers`
- `Pages`
- `Xcode`

`Spectacle` is intentionally not in the `Brewfile` because the legacy cask is no longer available in Homebrew.

## Manual Follow-Up

Managed shell setup:

```bash
./script/setup-shell
```

That helper is already called by `./setup-a-new-machine.sh`. It manages the shell stack this repo expects:

- `oh-my-zsh`
- `zsh-autosuggestions`
- `zsh-fzf-history-search`

`.zshrc` stays safe before and after those tools are installed because it only sources Oh My Zsh and plugin directories when they exist.

This repo expects `nvm` to use `~/.nvm`.

`./setup-a-new-machine.sh` installs the current Node LTS release through Homebrew `nvm`, then installs:

- `@openai/codex`

The repo-defined update aliases do not require `npm-check`. After Node is installed, `update_brew_npm_gem` uses the built-in `npm update -g` flow for global npm packages.

Claude Code is installed through the `claude-code` Homebrew cask in `Brewfile`.

Useful verification commands:

```bash
node --version
npm --version
codex --version
claude --version
```

AI coding tool authentication:

```bash
codex login
claude
```

`codex login` signs the Codex CLI in with your ChatGPT account and stores credentials locally. Starting `claude` prompts you to authenticate Claude Code with either a Claude subscription or Anthropic Console account.

Anthropic's quickstart also supports a native install script for Claude Code, but this repo uses the Homebrew cask so the install stays in `Brewfile`.

GitHub setup:

```bash
./script/setup-github-auth
```

That helper opens the GitHub CLI browser flow, sets GitHub's git protocol to SSH, configures the `open` alias for `repo view --web`, prompts to create or upload an SSH key if needed, tests `ssh -T git@github.com`, and updates this repo's `origin` remote to SSH.

Mac preferences that still need to be done manually:

- Show battery percentage
- Fix Finder sidebar and other Finder preferences
- Change mouse scroll direction
- Change mouse tap-to-click
- Download JetBrains Mono from <https://www.jetbrains.com/lp/mono/> and add it in Font Book

If you installed optional tools, the Dock helpers can save and restore the repo's Dock layout with `dockutil`:

```bash
./bin/capture-dock
./script/setup-dock
```

`./bin/capture-dock` snapshots your current Dock into `dock/layout.sh`. `./script/setup-dock` clears the Dock and recreates it from that saved layout, including right-side folder stacks such as `Downloads`.

Shell quality-of-life notes:

- `direnv` is hooked automatically from `.zshrc` when it is installed, so entering a directory can load or unload project-specific environment variables
- `zoxide` is also hooked automatically when optional tools are installed, so `z foo` jumps to frequently used directories without manual bookmarks
- interactive shells wrap `brew install` and prompt you to review `Brewfile` or `Brewfile.optional` after successful installs
- the old `ag` alias has been removed in favor of native `rg` and `fd`

## Dotfiles And Helper Scripts

Run `./move-in.sh` to link the dotfiles this repo intentionally manages in `$HOME`:

- `.aliases`
- `.exports`
- `.extras`
- `.functions`
- `.gitconfig`
- `.zshrc`

This repo intentionally splits helpers into two places:

- `bin/` for user-facing commands that should be available in `~/bin`
- `script/` for repo-only setup/bootstrap helpers that should be run from this checkout

`./move-in.sh` symlinks the regular files in `bin/` into `~/bin`.

It does not link repo documentation, `script/` helpers, or `Brewfile*` by default.

That means these helper scripts are available on your `PATH` as symlinks from `~/bin`:

- `add-ruby`
- `capture-dock`
- `pull-request.sh`
- `symlinkToDotfilesRepo.sh`
- `update-node-lts`

Repo-only setup helpers now live in `script/`:

- `setup-ai-coding-tools`
- `setup-dock`
- `setup-github-auth`
- `setup-shell`

`bin/add-ruby` installs a Ruby version with `ruby-install` and updates `~/.extras` so `chruby` selects it automatically.
`bin/capture-dock` snapshots the current Dock into `dock/layout.sh`.
`bin/pull-request.sh` opens the GitHub compare view for the current branch.
`bin/symlinkToDotfilesRepo.sh` is useful for moving files into the dotfiles repo and replacing them with symlinks.
`script/setup-ai-coding-tools` installs the current Node LTS release through Homebrew `nvm`, then installs Codex globally with npm.
`script/setup-dock` uses `dockutil` to recreate the Dock from `dock/layout.sh`.
`script/setup-github-auth` authenticates GitHub with `gh`, sets SSH as the preferred git protocol, configures the `open` alias for `repo view --web`, tests the SSH connection, and switches this repo's `origin` remote to SSH.
`script/setup-shell` installs or updates the Oh My Zsh framework and the specific plugins this repo enables in `.zshrc`.

## Postgres

Postgres is part of the default bootstrap now. The `Brewfile` installs:

- `postgresql@16`
- `libpq`

`postgresql@16` is configured with `restart_service: :changed`, so Homebrew Bundle will start or restart it when the formula is installed or updated.

After opening a new shell, `.exports` puts Homebrew `libpq` on your `PATH`, so `psql` and `pg_config` should be available without a global Bundler override.

Useful commands:

```bash
brew services start postgresql@16
brew services stop postgresql@16
psql --version
pg_config --version
```
