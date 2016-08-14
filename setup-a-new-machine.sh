# Assumes the user has cloned or downloaded the following repo https://github.com/davidrossdegroot/dotfiles and is in the root directory
# when this file is run. 

git clone git://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh

cp vim_runtime/my_configs.vim ~/vim_runtime/my_configs.vim

cp .bash_prompt ~/.bash_prompt

cp .bash_profile ~/.bash_profile

source ~/.bash_profile
