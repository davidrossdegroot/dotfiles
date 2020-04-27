#/bin/bash

echo "Type the directory or file relative to the HOME directory. E.g. .functions or bin/myScript.sh, followed by [ENTER]:"

read file

mv ~/$file ~/workspace/didit-dotfiles/$file
ln -s /Users/drdegroo/workspace/didit-dotfiles/$file /Users/drdegroo/$file
