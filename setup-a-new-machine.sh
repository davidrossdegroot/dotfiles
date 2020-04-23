# pick out what you want to do from here

#- [ ] Install chrome — login and do the sync
#- [ ] Download xcode from App Store
#- [ ] Change battery to show percentage 
#- [ ] Removed apps from dock that I don’t use. make dock nicer add terminal to dock etc.
#- [ ] Change mouse scroll direction
#- [ ] Change mouse to touch to click

#install homebrew https://brew.sh/ 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew update

# Upgrade any already-installed formulae
brew upgrade


# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed
# note to self -- update aliases with sed='gsed'

# Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash

brew install bash-completion

# Install wget with IRI support
brew install wget

# Install more recent versions of some OS X tools
brew install vim --with-override-system-vi 
brew install nano
brew install grep
brew install openssh
brew install screen

# z hopping around folders
brew install z

# run this script when this file changes guy.
brew install entr

# github util. gotta love `hub fork`, `hub create`, `hub checkout <PRurl>`
brew install hub


# mtr - ping & traceroute. best.
brew install mtr

# Install other useful binaries
brew install the_silver_searcher
brew install fzf # uses ctrl+r for command history searching

brew install git
brew install imagemagick # this one i might need to do an alias for
brew install node # This installs `npm` too using the recommended installation method
brew install pv
brew install rename
brew install tree
brew install ranger
brew install zopfli
brew install ffmpeg # prob don't need this in the future

brew install terminal-notifier
brew install pidcat   # colored logcat guy

brew install ncdu # find where your diskspace went

brew install zsh

# Remove outdated versions from the cellar
brew cleanup

# Install native apps

brew cask install spectacle
brew cask install gyazo
brew cask install 1password

# dev
brew cask install iterm2
brew cask install sublime-text
brew cask install visual-studio-code


git clone git://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh

# copy the files I want over to home directory. Symlinks maybe better option, but don't have time (or want) to research right now.

cp vim_runtime/my_configs.vim ~/vim_runtime/my_configs.vim
cp .bash_prompt ~/.bash_prompt
cp .bash_profile ~/.bash_profile
cp .aliases ~/.aliases
cp -R fish/ ~/fish
cp .functions ~/.functions
cp .exports ~/.exports
cp .dircolors ~/.dircolors
cp .gitconfig ~/.gitconfig

# Install Node... brew might be a better option... looking into it
#curl "https://nodejs.org/dist/latest/node-${VERSION:-$(wget -qO- https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')}.pkg" > "$HOME/Downloads/node-latest.pkg" && sudo installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"

# Type `git open` to open the GitHub page or website for a repository.
npm install -g git-open

# fancy listing of recent branches
npm install -g git-recent

# sexy git diffs
npm install -g diff-so-fancy

# trash as the safe `rm` alternative
npm install --global trash-cli



source ~/.bash_profile
