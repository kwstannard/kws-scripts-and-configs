call plug#begin('~/.vim/bundle')
" source ~/scripts/vim_plugs.vim
source ~/scripts/common_plugs.vim
call plug#end()

rubyfile ~/scripts/vim/convert_let.rb

function! ConvertLet()
  ruby ConvertLet.new.call
endfunction

nnoremap <leader>ch :call ConvertHash()<cr>

rubyfile ~/scripts/vim/convert_hash.rb

function! ConvertHash()
  ruby ConvertHash.new.call
endfunction

rubyfile ~/scripts/vim/corresponding_file_openner.rb
function! OpenCorrespondingFile()
  ruby vim=Struct.new(:commander, :window).new(VIM, VIM::Window.current); CorrespondingFileOpenner.new(vim).open
endfunction

source ~/scripts/common.vim
