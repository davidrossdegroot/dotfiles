# pick out what you want to do from here

#- [ ] Install chrome — login and do the sync
#- [ ] Download xcode from App Store
#- [ ] Change battery to show percentage 
#- [ ] Removed apps from dock that I don’t use. make dock nicer add terminal to dock etc.
#- [ ] Change mouse scroll direction
#- [ ] Change mouse to touch to click

# ruby installs 
# https://github.com/postmodern/ruby-install?tab=readme-ov-file#install 
#
# and https://github.com/postmodern/chruby?tab=readme-ov-file#install 


## brew stuff
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

brew install bash-completion

# Install wget with IRI support
brew install wget

# Install more recent versions of some OS X tools
brew install vim
brew install nano
brew install grep

brew install fzf # uses ctrl+r for command history searching

brew install ranger # not sure if i'll use it but like file explorer view
brew install pyenv # used to install python. pyenv install I think should work after this is installed


# fancy listing of recent branches
npm install -g git-recent

# sexy git diffs
npm install -g diff-so-fancy

# trash as the safe `rm` alternative
npm install --global trash-cli


# symlink it up!
./symlink-setup.sh
