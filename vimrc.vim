call pathogen#infect()
syntax enable
set t_Co=256
set nocompatible
set nowrap
set scrolloff=5
set autoindent
set smartindent
set numberwidth=6
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab
set noignorecase
set smartcase
set backspace=indent,eol,start    " backspace through everything in insert mode
set laststatus=2
set wildmode=list:full,full       " tab completion in command line
set wildmenu
set splitbelow
set splitright

set backupdir=~/.vim/backup
"set directory=~/.vim/swap
set noswapfile

"function! FontSizeChange(size)
"  let basesize=12
"  if(a:size > basesize)
"    let totallines=&lines * basesize / a:size
"  else
"    let totallines=&lines * a:size / basesize
"  end
"
"  let &lines=totallines
"  exec 'set guifont=consolas:h' . a:size
"  set winheight=999
"  echo totallines
"endfunc

nnoremap <leader>cl :call ConvertLet()<cr>

rubyfile ~/scripts/vim/convert_let.rb

function! ConvertLet()
  ruby ConvertLet.new.call
endfunction

nnoremap <leader>ch :call ConvertHash()<cr>

rubyfile ~/scripts/vim/convert_hash.rb

function! ConvertHash()
  ruby ConvertHash.new.call
endfunction

if &diff
  nmap <down>
  nmap <left> :diffget //2<cr>
  nmap <right> :diffget //3<cr>
  nmap <up> :only<cr>
end

nnoremap ; :

nnoremap y% :%y+<CR>

nnoremap \<c>' :s/'/"/g<cr>
nnoremap \<c>" :%s/'/"/g<cr>

filetype plugin indent on

" RELATIVE LINE NUMBERING
set relativenumber
set number

"au InsertEnter * :set number
"au InsertLeave * :set relativenumber

"au BufLeave * :set number
"au BufEnter * :set relativenumber
 
"function! FocusLose()
"  if(empty(hasntNumber))
"    :set number
"  else
"    :set nonumber
"  endif
"endfunc
"
"function! FocusGain()
"  if(mode() == 'i')
"    :set number
"  else
"    :set relativenumber
"  endif
"endfunc
" 
"au FocusLost * :call FocusLose()
"au FocusGained * :call FocusGain()

" clear all buffers
nnoremap <C-delete> :bufdo<space>bd<Cr>
nnoremap <C-S-delete> :bufdo<space>bd<Cr>:q<Cr>
nnoremap <C-backspace> :windo<space>bd<Cr>

" tabs
nnoremap J :tabprevious<cr>
nnoremap K :tabnext<cr>

" mush esc
inoremap jk <esc>
inoremap kj <esc>
inoremap JK <esc>
inoremap KJ <esc>
inoremap Jk <esc>
inoremap Kj <esc>
inoremap jK <esc>
inoremap kJ <esc>

"save file
nnoremap <S-s> :wa<Cr>
nnoremap <leader>d :!mkdir -p %:h<Cr>

"logging

autocmd BufWritePre * %s/\(\w\)\s\+$/\1/ge

au FileType eruby filetype indent off
au FileType eruby filetype indent on

"whitespace highlighting

hi ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace '\s\+$'

" long line highlighing

highlight LongLines ctermbg=18 guibg=#333300
au FileType ruby,javascript,coffee,vim call matchadd('LongLines', '^.\{80,119}$', -1)

highlight VeryLongLines ctermbg=52 guibg=#330000
au FileType ruby,javascript,coffee,vim call matchadd('VeryLongLines', '^.\{120,}$', -1)

" indent highlighting

"highlight OddIndent ctermbg=236 guibg=#303030
"highlight EvenIndent ctermbg=240 guibg=#585858

"au FileType * call matchadd('OddIndent', '\%(^\|\%(\s\s\)\)\zs\s\s\ze\s\s')
"au FileType * call matchadd('EvenIndent', '\(\s\s\)\zs\1\ze\1')

" STATUS LINE
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" OPEN FILES IN DIRECTORY OF CURRENT FILE
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>E :edit ./
map <leader>v :view %%
map <leader>V :view ./
map <leader>t :tabnew %%
map <leader>T :tabnew ./
map <leader>s :split %%
map <leader>S :split ./
map <leader>r :bufdo<space>e<cr>
map <leader><c-o> :call OpenCorrespondingFile()<cr>

rubyfile ~/scripts/vim/corresponding_file_openner.rb
function! OpenCorrespondingFile()
  ruby vim=Struct.new(:commander, :window).new(VIM, VIM::Window.current); CorrespondingFileOpenner.new(vim).open
endfunction

" RENAME CURRENT FILE
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>N :call RenameFile()<cr>

" GIT MOVE CURRENT FILE
function! GitMoveFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':Gmove ' . new_name
    redraw!
  endif
endfunction
map <leader>n :call GitMoveFile()<cr>

nnoremap <leader><leader> <c-^>

" word wrapping
nnoremap <leader>" "wciw""<esc><left>"wp
nnoremap <leader>' "wciw''<esc><left>"wp
nnoremap <leader>( "wciw()<esc><left>"wp
nnoremap <leader>{ "wciw{}<esc><left>"wp
nnoremap <leader>[ "wciw[]<esc><left>"wp

" shebang filetype detection

function! s:DetectFileType()
  if did_filetype()
    return
  endif
  if getline(1) =~ '^#!.*ruby'
    setfiletype ruby
  endif
endfunction
au BufNewFile,BufRead Guardfile,.Guardfile setfiletype ruby

au BufNewFile,BufRead * :call s:DetectFileType()

au BufEnter * :checktime
