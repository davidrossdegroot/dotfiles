# Core bootstrap CLI tools. These are expected on every machine this repo sets up.
brew "bash-completion"
brew "bat"
brew "chruby"
brew "coreutils"
brew "direnv"
brew "fd"
brew "findutils"
brew "fzf"
brew "gh"
brew "gnu-sed"
brew "grep"
brew "imagemagick"
brew "jq"
brew "libpq"
brew "mas"
brew "moreutils"
brew "mtr"
brew "nano"
brew "nvm"
brew "postgresql@16", restart_service: :changed
brew "pyenv"
brew "ranger"
brew "ripgrep"
brew "ruby-install"
brew "shellcheck"
brew "shfmt"
brew "tree"
brew "vim"
brew "wget"

# GUI apps installed with Homebrew Cask.
cask "1password"
cask "claude"
cask "claude-code"
cask "chatgpt"
cask "docker-desktop"
cask "google-chrome"
cask "iterm2"
cask "ollama-app"
cask "sublime-text"
cask "visual-studio-code"
cask "zoom"

# Spectacle is intentionally omitted because the legacy cask is no longer
# available in Homebrew.

# Mac App Store apps. Sign in to the App Store before running brew bundle, or
# set SKIP_APP_STORE=1 to skip these entries during bootstrap.
mas "GarageBand", id: 682658836
mas "iMovie", id: 408981434
mas "Keynote", id: 361285480
mas "Numbers", id: 361304891
mas "Pages", id: 361309726
mas "Xcode", id: 497799835

# Added by ./bin/brew-sync for locally installed formulae.
brew "dockutil"
brew "openssl@3"

