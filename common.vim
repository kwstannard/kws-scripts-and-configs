set nocompatible
source ~/scripts/configs/vim/buffers.vim
syntax enable
set shell=/bin/bash
set history=1000
set t_Co=256
set nowrap
set scrolloff=5
set autoindent
set smartindent
set numberwidth=6
"set foldcolumn=2
highlight Folded ctermbg=0 ctermfg=15
set tabstop=2                     " a tab is two spaces
set softtabstop=-1                " use shiftwidth
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab
" au FileType ruby setlocal tabstop=3 shiftwidth=3
" au FileType javascript setlocal tabstop=3 shiftwidth=3

" add '-' to the set of word chars so that * will pick up, eg:
" foo-bar some-dashed-key et-cetera
au FileType ruby,yaml setlocal iskeyword=@,48-57,-,_,192-255

set noignorecase
set smartcase
set backspace=indent,eol,start    " backspace through everything in insert mode
set laststatus=2
set wildmode=full       " tab completion in command line
set wildmenu
set wildcharm=<C-Z>
set splitbelow
set splitright
set hidden

set path=.,,,,lib/**,config/**,app/**

set backupdir=~/.vim/backup
"set directory=~/.vim/swap
set noswapfile

" fuzzy find
set rtp+=/usr/local/opt/fzf

let g:sqlutil_load_default_maps = 0

" get rid of esc delay
set timeoutlen=1000 ttimeoutlen=0

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

nnoremap <enter> J

filetype plugin indent on

au FocusLost * silent! wa
" clear all buffers
nnoremap <leader><delete> :bufdo<space>bd<Cr>
nnoremap <leader><s-delete> :bufdo<space>bd<Cr>:q<Cr>
nnoremap <leader><backspace> :windo<space>bd<Cr>

" mush esc
call arpeggio#map('i','',0,'jk','<esc>')
call arpeggio#map('i','',0,'JK','<esc>')
call arpeggio#map('i','',0,'Jk','<esc>')
call arpeggio#map('i','',0,'Kj','<esc>')

"save file
nnoremap <S-s> :wa<Cr>:!./trc<CR>
nnoremap <leader>d :!mkdir -p %:h<Cr>

"logging

autocmd BufWritePre *.rb %s/\s\+$//ge

au FileType eruby filetype indent off
au FileType eruby filetype indent on

"colorscheme changes
highlight Normal ctermbg=Black ctermfg=White
highlight Comment ctermfg=LightRed
highlight Define ctermfg=darkgrey
highlight Type ctermfg=Grey
highlight Number ctermfg=LightYellow
highlight Constant ctermfg=LightMagenta
highlight Function ctermfg=lightgrey
highlight Statement ctermfg=grey
highlight rubyBlockParameterList ctermfg=grey
highlight rubyMethodBlock ctermfg=lightgrey
highlight rubyDoBlock ctermfg=lightgrey
highlight rubyCurlyBlock ctermfg=lightgrey
highlight rubyCaseExpression ctermfg=lightgrey
highlight rubySymbol ctermfg=LightYellow
highlight Identifier ctermfg=grey
highlight PreProc ctermfg=cyan

highlight LineNr ctermfg=DarkGrey

"whitespace highlighting

hi ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace '\s\+$'

" diff highlighting
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" ale highlighting
highlight ALEWarning ctermbg=DarkRed

let g:ale_lint_on_enter=0

" long line highlighing

"highlight LongLines ctermbg=18 guibg=#333300
"au FileType ruby,javascript,coffee,vim call matchadd('LongLines', '^.\{80,107}$', -1)

"highlight VeryLongLines ctermbg=52 guibg=#330000
"au FileType ruby,javascript,coffee,vim call matchadd('VeryLongLines', '^.\{108,}$', -1)

" indent highlighting

"highlight OddIndent ctermbg=236 guibg=#303030
"highlight EvenIndent ctermbg=240 guibg=#585858

"au FileType * call matchadd('OddIndent', '\%(^\|\%(\s\s\)\)\zs\s\s\ze\s\s')
"au FileType * call matchadd('EvenIndent', '\(\s\s\)\zs\1\ze\1')

" STATUS LINE
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" OPEN FILES IN DIRECTORY OF CURRENT FILE
map <leader>v :view <C-r>=(expand('%:h')).'/'<cr>
map <leader>V :view ./

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
    exec ':GMove ' . new_name
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
" au BufNewFile,BufRead Guardfile,.Guardfile setfiletype ruby

au BufNewFile,BufRead * :call s:DetectFileType()

au BufEnter * :checktime

" " rotate windows
" nnoremap <c-w><end> :tabdo wincmd h \| wincmd K<cr>
" nnoremap <c-w><home> :tabdo wincmd k \| wincmd H<cr>


let g:ale_lint_delay=500
let g:ale_set_signs=0

let g:ale_fixers = {
      \   'ruby': [
      \       'ale#fixers#rubocop#Fix',
      \   ],
      \}

let g:ale_ruby_rubocop_executable='rubocop'
let g:ale_ruby_rubocop_options='-except Layout/IndentationStyle'


call arpeggio#map('n','',0,'at',':ALEToggle<CR>')
call arpeggio#map('n','',0,'af',':ALEFix<CR>')


let g:ruby_indent_block_style = 'do'
let g:ruby_indent_access_modifier_style = 'indent'
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_recommended_style = 0


function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set spell noci nosi noai nolist noshowmode noshowcmd wrap linebreak
  set complete+=s
  set bg=light
  colors seoul256
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  normal ZZ
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
au VimEnter COMMIT_MSG,PULLREQ_EDITMSG,*.txt Goyo

let g:sort_motion_flags = "i"

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

let $BASH_ENV="~/scripts/vim.bash"
set stl+=%{ConflictedVersion()}

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_max_line_indicator = 'fill'
hi ColorColumn ctermbg=darkgrey
nnoremap giw :exec "normal v\<Plug>(textobj-indent-i)gw" <CR>

command! Abolish licence{e,s} license{}
command! Abolish licence{e,s} license{}
