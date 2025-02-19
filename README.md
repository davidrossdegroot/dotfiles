#  dotfiles

Used this for macbook air 2020 during the great quarantine of 2020 and for mac mini in Feb, 2025. 

- [ ] Install chrome — login and do the sync
- [ ] Download xcode from App Store and command line tools. Brew needs these.
- [ ] Change battery to show percentage
- [ ] fix finder sidebar and other finder stuff. I don't know how to programatically do that.
- [ ] Removed apps from dock that I don’t use
- [ ] Change mouse scroll direction
- [ ] Change mouse to touch to click

install oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
I'd recommend cloning this repo because each time I go through it, I kind of change stuff so you can keep this README open and just update it as you go along.

Go through `setup-a-new-machine.sh` and `brew.sh` and installed some of the stuff that I wanted.

Get the ctrl r key binding
- https://github.com/joshskidmore/zsh-fzf-history-search


### bin folder setup
```
# create the necessary home directory bin folder
mkdir ~/bin
# copy the files from this repo into your bin
cp dotfiles/* ~/bin/
```
This symlink file is pretty nice too for moving the files to the dotfiles repo and symlinking them
`bin/symlinkToDotfilesRepo.sh`


