call plug#begin('~/.vim/bundle')
source ~/scripts/nvim_plugs.vim
source ~/scripts/common_plugs.vim
call plug#end()

rubyfile ~/scripts/vim/convert_let.rb

function! ConvertLet()
  ruby ConvertLet.new.call
endfunction

nnoremap <leader>cl :call ConvertLet()<cr>

rubyfile ~/scripts/vim/convert_hash.rb

function! ConvertHash()
  ruby ConvertHash.new.call
endfunction

nnoremap <leader>ch :call ConvertHash()<cr>

rubyfile ~/scripts/vim/corresponding_file_openner.rb
function! OpenCorrespondingFile()
  ruby vim=Struct.new(:commander, :window).new(VIM, VIM::Window.current); CorrespondingFileOpenner.new(vim).open
endfunction

map <leader><c-o> :call OpenCorrespondingFile()<cr>

source ~/scripts/common.vim
source ~/.config/work.vim

au TermOpen * set nonumber
au TermOpen * set norelativenumber
au TermOpen * echo 'HI!!'
