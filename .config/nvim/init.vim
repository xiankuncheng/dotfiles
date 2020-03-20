set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source $HOME/.config/nvim/config/general.vimrc
source $HOME/.config/nvim/config/maps.vimrc
source $HOME/.config/nvim/config/plugins.vimrc
source $HOME/.config/nvim/config/plugin-config.vimrc
