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

If you are not signed in to the App Store yet, you can skip those installs for now:

```bash
SKIP_APP_STORE=1 ./setup-a-new-machine.sh
```

The package source of truth is `Brewfile`. `setup-a-new-machine.sh` is the human-friendly entrypoint, and `brew.sh` is the package-only helper that runs `brew bundle`.

This bootstrap assumes macOS or Xcode Command Line Tools already provide:

- `bash`
- `git`
- `zsh`

Those are intentionally not installed from Homebrew.

## What Gets Installed

Package installs are managed through `brew bundle` and include:

- Homebrew formulae from `Brewfile`
- GUI apps through Homebrew Cask
- Mac App Store apps through `mas`

The default formula list also includes local Postgres support through:

- `postgresql@16`
- `libpq`

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
- Remove apps from the Dock that you do not use
- Change mouse scroll direction
- Change mouse tap-to-click
- Download JetBrains Mono from <https://www.jetbrains.com/lp/mono/> and add it in Font Book

## Dotfiles And Helper Scripts

Run `./move-in.sh` to link the dotfiles this repo intentionally manages in `$HOME`:

- `.aliases`
- `.exports`
- `.extras`
- `.functions`
- `.gitconfig`
- `.zshrc`

It does not link repo documentation, bootstrap scripts, `Brewfile`, or `bin/*` by default.

If you want the helper scripts on your `PATH`:

```bash
mkdir -p ~/bin
cp bin/* ~/bin/
```

`bin/symlinkToDotfilesRepo.sh` is also useful for moving files into the dotfiles repo and replacing them with symlinks.

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
