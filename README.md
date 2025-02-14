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

Then I started to go through `setup-a-new-machine.sh` and `brew.sh` and installed some of the stuff that I wanted. 

Eventually, you'll want to setup a new key on your machine:
```
 ssh-keygen -t rsa -b 4096 -C "davidrossdegroot@gmail.com"
 eval "$(ssh-agent -s)"
```

You can setup your ~/.ssh/config file to save the passphrase
```
Host *
  AddKeysToAgent yes
  IgnoreUnknown UseKeychain
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
```
Then add the key to your agent and it should save it to your keychain now.
```
ssh-add -K ~/.ssh/id_rsa
```

Go here: https://github.com/settings/ssh/new paste in the public one.

Then clone this repo:

```
mkdir workspace
cd workspace
git@github.com:davidrossdegroot/dotfiles.git
```

At this point you can run a script like `.osx` by running 
```
bash .osx
```

Then run 
```
./symlink-setup.sh
```

install awesome vim
```
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
```
Get the ctrl r key binding
```
$(brew --prefix)/opt/fzf/install 
```

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


