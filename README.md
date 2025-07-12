#  dotfiles

Used this for macbook air 2020 during the great quarantine of 2020 and for mac mini in Feb, 2025. 

- [ ] Install chrome — login and do the sync
- [ ] Download xcode from App Store and command line tools. Brew needs these.
- [ ] Change battery to show percentage
- [ ] fix finder sidebar and other finder stuff. I don't know how to programatically do that.
- [ ] Removed apps from dock that I don't use
- [ ] Change mouse scroll direction
- [ ] Change mouse to touch to click
- [ ] Download JetBrains Mono font https://www.jetbrains.com/lp/mono/  -> expand the folder and then add it to Documents folder
- [ ] Open FontBook -> File -> Add Fonts to current user.

### install oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
You can google these plugins and do their git installations for oh-my-zsh `zsh-autosuggestions zsh-fzf-history-search`

### Clone this repo

I'd recommend cloning this repo because each time I go through it, I kind of change stuff so you can keep this README open and just update it as you go along.

Go through `setup-a-new-machine.sh` and `brew.sh` and installed some of the stuff that I wanted manually. 

Get the ctrl r key binding
- https://github.com/joshskidmore/zsh-fzf-history-search

One thing you could do too which might save some time is to run the move-in.sh script which _should_ set up all the symlinks for you (not tested). Or you can manually copy these over (see #bin-folder-setup)

### bin folder setup
```
# create the necessary home directory bin folder
mkdir ~/bin
# copy the files from this repo into your bin
cp dotfiles/* ~/bin/
```
This symlink file is pretty nice too for moving the files to the dotfiles repo and symlinking them
`bin/symlinkToDotfilesRepo.sh`

### Postgres
Install postgres using brew. This should let you use postgres for a rails app for example.
```
brew install postgresql@16
#  for some reason mac M3s or whatever need this
brew install libpq
# this tells bundler that you want to use this special config (globally)
bundle config --global build.pg --with-pg-config=/opt/homebrew/opt/libpq/bin/pg_config
# this will ensure it starts when you start your computer
brew services start postgresql@16
```
