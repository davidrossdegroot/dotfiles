# pick out what you want to do from here

#- [ ] Install chrome — login and do the sync
#- [ ] Download xcode from App Store
#- [ ] Change battery to show percentage 
#- [ ] Removed apps from dock that I don’t use. make dock nicer add terminal to dock etc.
#- [ ] Change mouse scroll direction
#- [ ] Change mouse to touch to click

# fix xcode first (you can look at paul irish's repo to get the full script to install xcode, but app store + this worked for me too.
sudo xcode-select --switch /Applications/Xcode.app

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

# autocompletion for git branch names https://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# Type `git open` to open the GitHub page or website for a repository.
npm install -g git-open

# fancy listing of recent branches
npm install -g git-recent

# sexy git diffs
npm install -g diff-so-fancy

# trash as the safe `rm` alternative
npm install --global trash-cli

# more readable git diffs
npm install --global diff-so-fancy


# install better nanorc config
# https://github.com/scopatz/nanorc
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

# github.com/rupa/z   - oh how i love you
git clone https://github.com/rupa/z.git ~/code/z
# consider reusing your current .z file if possible. it's painful to rebuild :)
# z is hooked up in .bash_profile


# github.com/thebitguru/play-button-itunes-patch
# disable itunes opening on media keys
git clone https://github.com/thebitguru/play-button-itunes-patch ~/code/play-button-itunes-patch

# install pyenv
brew install pyenv
# get latest stable python version
pyenv install --list
# install it
pyenv install 3.8.2
# use it locally -- I think all of the other path stuff should be already setup.
pyenv local 3.8.2
# verify with
python --version

# install pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py

# install pygmatize for our lovely cat output
pip install Pygments

# change to bash 4 (installed by homebrew)
BASHPATH=$(brew --prefix)/bin/bash
#sudo echo $BASHPATH >> /etc/shells
sudo bash -c 'echo $(brew --prefix)/bin/bash >> /etc/shells'
chsh -s $BASHPATH # will set for current user only.
echo $BASH_VERSION # should be 4.x not the old 3.2.X
# Later, confirm iterm settings aren't conflicting.

# setting up the sublime symlink
ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl

# install nvm (Node Version Nanager, https://github.com/nvm-sh/nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

git clone git://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh

# Install Node... brew might be a better option... looking into it
#curl "https://nodejs.org/dist/latest/node-${VERSION:-$(wget -qO- https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')}.pkg" > "$HOME/Downloads/node-latest.pkg" && sudo installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"

# Type `git open` to open the GitHub page or website for a repository.
npm install -g git-open
# faster git server communication.
# like a LOT faster. https://opensource.googleblog.com/2018/05/introducing-git-protocol-version-2.html
git config protocol.version 2


sh .osx

# setup and run Rescuetime!

###
##############################################################################################################


# fancy listing of recent branches
npm install -g git-recent

# sexy git diffs
npm install -g diff-so-fancy

# trash as the safe `rm` alternative
npm install --global trash-cli

# symlink it up!
./symlink-setup.sh
