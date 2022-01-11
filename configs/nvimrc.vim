call plug#begin('~/.vim/bundle')
source ~/scripts/nvim_plugs.vim
source ~/scripts/common_plugs.vim
call plug#end()

function! ConvertLet()
  rubyfile ~/scripts/vim/convert_let.rb
  ruby ConvertLet.new.call
endfunction

nnoremap <leader>cl :call ConvertLet()<cr>
vnoremap <leader>cl :call ConvertLet()<cr>

function! ConvertHash()
  rubyfile ~/scripts/vim/convert_hash.rb
  ruby ConvertHash.new.call
endfunction

nnoremap <leader>ch :call ConvertHash()<cr>
vnoremap <leader>ch :call ConvertHash()<cr>

function! OpenCorrespondingFile()
  rubyfile ~/scripts/vim/corresponding_file_openner.rb
  ruby vim=Struct.new(:commander, :window).new(VIM, VIM::Window.current); CorrespondingFileOpenner.new(vim).open
endfunction

map <leader><c-o> :call OpenCorrespondingFile()<cr>

source ~/scripts/common.vim
source ~/.config/work.vim

au TermOpen * set nonumber
au TermOpen * set norelativenumber
au TermOpen * echo 'HI!!'
