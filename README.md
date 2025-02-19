#  dotfiles

Used this for macbook air 2020 during the great quarantine of 2020. That was redundant. Sorry. So I did a few things manually. I probably could have just followed the `setup-a-new-machine.sh` script which would have done things like get xcode.

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
I'd recommend cloning this repo because each time I go through it, I kind of change stuff. So you'll follow the instructions in github to get that setup.


Then I started to go through `setup-a-new-machine.sh` and `brew.sh` and installed some of the stuff that I wanted. 

Then run 
```
./symlink-setup.sh
```

Get the ctrl r key binding
- https://github.com/joshskidmore/zsh-fzf-history-search


I installed the https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync vs code plugin
and logged in and chose to use the gist where my settings were already saved in GH. Then I chose settings for the plugin and chose to autodownload the extensions. Then restarted VS Code.

Run the "Add code to PATH" command in vscode.

### bin folder setup
```
# create the necessary home directory bin folder
mkdir ~/bin
# symlink each to the dotfiles repo so anything changed in here is updated in the repo
# TODO: make this a loop for each file in that directory. Add to symlink setup.
ln -s /Users/daviddegroot/workspace/dotfiles/bin/symlink-to-dotfiles.sh /Users/daviddegroot/bin/symlink-to-dotfiles.sh
chmod +x bin/*.sh
```


