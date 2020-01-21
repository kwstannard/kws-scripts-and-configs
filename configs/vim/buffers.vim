map <leader>b :edit <C-r>=expand('%:p:h')<cr>/
map <leader>B :edit ./
map <leader>t <leader>b
map <leader>T <leader>B

nnoremap J :syntax off<cr>:bprevious<cr>:syntax on<cr>

nnoremap K :syntax off<cr>:bnext<cr>:syntax on<cr>

augroup auto_save
  autocmd!
  au InsertLeave * silent! w
  au TextChanged * silent! w
augroup END
