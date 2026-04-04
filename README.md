# dotfiles

Used this for a MacBook Air in 2020 and a Mac mini in February 2025.

## Canonical bootstrap flow

1. Install Xcode Command Line Tools and Homebrew.
2. Clone this repo.
3. Sign in to the Mac App Store if you want `mas` to install App Store apps.
4. Run:

```bash
./setup-a-new-machine.sh
```

If you are not signed in to the App Store yet, you can skip those installs for now:

```bash
SKIP_APP_STORE=1 ./setup-a-new-machine.sh
```

The package source of truth is `Brewfile`. `setup-a-new-machine.sh` is the human-friendly entrypoint, and `brew.sh` is the package-only helper that runs `brew bundle`.

## What Gets Installed

Package installs are managed through `brew bundle` and include:

- Homebrew formulae from `Brewfile`
- GUI apps through Homebrew Cask
- Mac App Store apps through `mas`

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

After opening a new shell, run:

```bash
nvm install --lts
```

Mac preferences that still need to be done manually:

- Show battery percentage
- Fix Finder sidebar and other Finder preferences
- Remove apps from the Dock that you do not use
- Change mouse scroll direction
- Change mouse tap-to-click
- Download JetBrains Mono from <https://www.jetbrains.com/lp/mono/> and add it in Font Book

## Dotfiles And Helper Scripts

`move-in.sh` can symlink repo files into `$HOME`, but it is still broader than it should be. Review it before using it on a fresh machine.

If you want the helper scripts on your `PATH`:

```bash
mkdir -p ~/bin
cp bin/* ~/bin/
```

`bin/symlinkToDotfilesRepo.sh` is also useful for moving files into the dotfiles repo and replacing them with symlinks.

## Postgres

For Rails work:

```bash
brew install postgresql@16
brew install libpq
bundle config --global build.pg --with-pg-config="$(brew --prefix libpq)/bin/pg_config"
brew services start postgresql@16
```
