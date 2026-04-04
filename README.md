# dotfiles

Used this for a MacBook Air in 2020 and a Mac mini in February 2025.

## Canonical bootstrap flow

1. Install Xcode Command Line Tools:

```bash
xcode-select --install
```

2. Install Homebrew.
3. Clone this repo.
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

The package source of truth is `Brewfile` for the default bootstrap and `Brewfile.optional` for opt-in extras. `setup-a-new-machine.sh` is the human-friendly entrypoint, and `brew.sh` is the package-only helper that runs `brew bundle`.

This bootstrap assumes macOS or Xcode Command Line Tools already provide:

- `bash`
- `git`
- `zsh`

Those are intentionally not installed from Homebrew.

## Which Script Does What

`./setup-a-new-machine.sh` is the software bootstrap step for a new Mac. It runs `./brew.sh`, which runs `brew bundle` against `Brewfile` to install the default CLI tools, casks, and optional Mac App Store apps. Pass `--optional-tools` or set `INSTALL_OPTIONAL_TOOLS=1` to also install the extras from `Brewfile.optional`. It does not symlink repo files into `$HOME`.

`./move-in.sh` is the dotfile linking step. It creates symlinks for the small set of home-directory config files this repo intentionally manages, and it symlinks every file in `bin/` into `~/bin`. It does not install Homebrew packages, casks, or App Store apps.

If you are setting up a fresh machine, the intended order is:

1. Run `./setup-a-new-machine.sh` to install software.
2. Review `./move-in.sh`, then run it if you want the managed dotfiles linked into `$HOME` and the repo's `bin/*` scripts symlinked into `~/bin`.

## What Gets Installed

Package installs are managed through `brew bundle` and include:

- Homebrew formulae from `Brewfile`
- Optional Homebrew formulae from `Brewfile.optional` when `--optional-tools` or `INSTALL_OPTIONAL_TOOLS=1` is used
- GUI apps through Homebrew Cask
- Mac App Store apps through `mas`

Required/default formulae now include the core Unix tooling this repo expects on every machine:

- `bat`
- `direnv`
- `fd`
- `gh`
- `jq`
- `ripgrep`
- `shellcheck`
- `shfmt`

The default formula list also includes local Postgres support through:

- `postgresql@16`
- `libpq`

Optional CLI extras are kept separate so the default bootstrap stays lean:

- `btop`
- `dockutil`
- `ncdu`
- `stow`
- `tmux`
- `zoxide`

This repo still uses `./move-in.sh` for its curated symlink flow, so `stow` is installed only as an extra tool rather than replacing that script outright.

Notable cask installs include:

- `1password`
- `claude`
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

Shell setup:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install whatever Oh My Zsh plugins you want, for example:

- `zsh-autosuggestions`
- `zsh-fzf-history-search`

This repo expects `nvm` to use `~/.nvm`.

After opening a new shell, run:

```bash
mkdir -p ~/.nvm
nvm install --lts
node --version
npm --version
```

Mac preferences that still need to be done manually:

- Show battery percentage
- Fix Finder sidebar and other Finder preferences
- Change mouse scroll direction
- Change mouse tap-to-click
- Download JetBrains Mono from <https://www.jetbrains.com/lp/mono/> and add it in Font Book

If you installed optional tools, `./bin/setup-dock` can reset the Dock with `dockutil`:

```bash
./bin/setup-dock
```

Shell quality-of-life notes:

- `direnv` is hooked automatically from `.zshrc` when it is installed
- `zoxide` is also hooked automatically when optional tools are installed, replacing the older `z` package with a faster `z` command
- the old `ag` alias has been removed in favor of native `rg` and `fd`

## Dotfiles And Helper Scripts

Run `./move-in.sh` to link the dotfiles this repo intentionally manages in `$HOME`:

- `.aliases`
- `.exports`
- `.extras`
- `.functions`
- `.gitconfig`
- `.zshrc`

It also symlinks every file in this repo's `bin/` directory into `~/bin`.

It does not link repo documentation, bootstrap scripts, or `Brewfile*` by default.

That means these helper scripts are available on your `PATH` as symlinks from `~/bin`:

- `add-ruby`
- `pull-request.sh`
- `setup-dock`
- `symlinkToDotfilesRepo.sh`

`bin/symlinkToDotfilesRepo.sh` is useful for moving files into the dotfiles repo and replacing them with symlinks.
`bin/setup-dock` uses `dockutil` to clear the Dock and add a small baseline set of apps that match this repo's bootstrap.

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
