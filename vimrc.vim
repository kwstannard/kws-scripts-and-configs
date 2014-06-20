syntax enable
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
set directory=~/.vim/swap

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

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

filetype plugin indent on

" RELATIVE LINE NUMBERING
set relativenumber

au InsertEnter * :set number
au InsertLeave * :set relativenumber

au BufLeave * :set number
au BufEnter * :set relativenumber
 
function! FocusLose()
"  if(empty(hasntNumber))
    :set number
"  else
"    :set nonumber
"  endif
endfunc

function! FocusGain()
  if(mode() == 'i')
    :set number
  else
    :set relativenumber
  endif
endfunc
 
au FocusLost * :call FocusLose()
au FocusGained * :call FocusGain()

function! FugitiveBufLeave()
  set winwidth=84
  call FocusGainNumbering()
endfunction
au FocusLost *.fugitiveblame* call FugitiveBufLeave()

function! FugitiveBufEnter()
  set winwidth=80
  set nonumber
endfunction
au FocusLost *.fugitiveblame* call FugitiveBufEnter()

" clear all buffers
nnoremap <C-delete> :bufdo<space>bd<Cr>

" tabs
nnoremap J :tabprevious<cr>
nnoremap K :tabnext<cr>

" mush esc
inoremap jk <esc>
inoremap kj <esc>

"save file
nnoremap <C-s> :wa<Cr>
nnoremap <leader>d :!mkdir -p %:h<Cr>

"logging

autocmd BufWritePre * %s/\(\w\)\s\+$/\1/ge

" block select commenting & uncommenting
au BufEnter *.rb map ,c :s/^/#/<CR>:nohlsearch<CR>
au BufEnter *.rb map ,u :s/^#//<CR>:nohlsearch<CR>

au BufEnter *.vim* map ,c :s/^/"/<CR>:nohlsearch<CR>
au BufEnter *.vim* map ,u :s/^"//<CR>:nohlsearch<CR>

au BufEnter *.haml* map ,c :s/^/-#/<CR>:nohlsearch<CR>
au BufEnter *.haml* map ,u :s/^-#//<CR>:nohlsearch<CR>

au BufEnter *.js map ,c :s/^/\/\//<CR>:nohlsearch<CR>
au BufEnter *.js map ,u :s/^\/\///<CR>:nohlsearch<CR>

au BufEnter *.erb filetype indent off
au BufLeave *.erb filetype indent on

"whitespace highlighting
   
hi ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace '\s\+$'

" long line highlighing

highlight LongLines guibg=#333300
au BufWinEnter *.rb,*.js,*.coffee,*.vim call matchadd('LongLines', '^.\{80,119}$', -1)
 
highlight VeryLongLines guibg=#330000
au BufWinEnter *.rb,*.js,*.coffee,*.vim call matchadd('VeryLongLines', '^.\{120,}$', -1)

" indent highlighting
"
function! IndentColoring()
  let indent_colors = ['#645640','#564832','#484024','#646452','#565644','#484834','#565656','#484848','#404040']
  let indent = len(indent_colors) - 1

  for icolor in indent_colors
    let indent_name = 'Indent' . indent
    let regex_pattern = '^\s\{' . (indent * 2 + 4) . '}\&^\s\{' . (indent * 2 + 1) . '}'
    let importance = 200 - indent
    exec 'highlight ' . indent_name . ' guibg=' . icolor
    call matchadd(indent_name, regex_pattern, importance)
    let indent -= 1
  endfor
endfunction

au BufWinEnter *.rb,*.js,*.html*,*.vim,*.coffee call IndentColoring()

" STATUS LINE
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" OPEN FILES IN DIRECTORY OF CURRENT FILE
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%
map <leader>t :tabnew %%
map <leader>s :call OpenCorrespondingFile()<cr>

function! OpenCorrespondingFile()
  let file_path = expand('%')
  if match(file_path, 'spec/') >= 0
    if match(file_path, '.js') >= 0
      let corresponding_file = substitute(substitute(expand('%'), 'spec/', 'public/', ''), '_spec\.', '\.', '')
    else
      let corresponding_file = substitute(substitute(expand('%'), 'spec/', 'app/', ''), '_spec\.', '\.', '')
    endif
  else
    let corresponding_file = substitute(substitute(expand('%'), '\(app\|public\)/', 'spec/', ''), '\(/\w\+\)\.', '\1_spec\.', '')
  endif
  exec ":split " . corresponding_file
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
