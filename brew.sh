#!/bin/bash
# tbh I kind of messed up and don't remember which of these I did.
# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade


# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --with-default-names


# Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash

brew install bash-completion

brew install homebrew/completions/brew-cask-completion

# Install wget with IRI support
brew install wget --with-iri

# Install more recent versions of some OS X tools
brew install vim --with-override-system-vi
brew install homebrew/dupes/nano
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

# z hopping around folders
brew install z

# github util. gotta love `hub fork`, `hub create`, `hub checkout <PRurl>`
brew install hub


# mtr - ping & traceroute. best.
brew install mtr

brew install fzf

brew install git
brew install imagemagick --with-webp
brew install tree

# nvm 
brew uninstall --ignore-dependencies node
brew uninstall --force node
brew install nvm
nvm install node # gets latest stable version

brew install zsh

# these are all the brew cask installs I did.. not sure I need all of them.

1password                      iterm2                         sublime-text
gyazo                          spectacle                      visual-studio-code

# Remove outdated versions from the cellar
brew cleanup
