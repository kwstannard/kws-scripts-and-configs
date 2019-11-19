call plug#begin('~/.vim/bundle')
source ~/scripts/nvim_plugs.vim
source ~/scripts/common_plugs.vim
call plug#end()

source ~/scripts/common.vim
source ~/.config/work.vim

au TermOpen * set nonumber
au TermOpen * set norelativenumber
au TermOpen * echo 'HI!!'
