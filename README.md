#  dotfiles

Used this for macbook air 2020 during the great quarantine of 2020. That was redundant. Sorry. So I did a few things manually.

- [ ] Install chrome — login and do the sync
- [ ] Download xcode from App Store
- [ ] Change battery to show percentage 
- [ ] Removed apps from dock that I don’t use
- [ ] Change mouse scroll direction
- [ ] Change mouse to touch to click

Then I started to go through `setup-a-new-machine.sh` and chose some of the stuff that I wanted.

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

At this point you can run a script like `.osx` or something. I'd review it first.

