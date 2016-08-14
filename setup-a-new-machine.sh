# Assumes the user has cloned or downloaded the following repo https://github.com/davidrossdegroot/dotfiles and is in the root directory
# when this file is run. 

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

# Type `git open` to open the GitHub page or website for a repository.
npm install -g git-open

# fancy listing of recent branches
npm install -g git-recent

# sexy git diffs
npm install -g diff-so-fancy

# trash as the safe `rm` alternative
npm install --global trash-cli



source ~/.bash_profile
