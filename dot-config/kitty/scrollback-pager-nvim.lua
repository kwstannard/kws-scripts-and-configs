vim.opt.encoding='utf-8'

vim.cmd("call plug#begin('~/.vim/bundle')")
vim.cmd("Plug 'mikesmithgh/kitty-scrollback.nvim'")
vim.cmd("call plug#end()")

require('kitty-scrollback').setup()
require('kitty-scrollback.api')

vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  callback = function(args)
    vim.opt.readonly = true
    vim.opt.write = false
    vim.opt.modifiable = false
    vim.keymap.set('n', 'ZZ', ':q!<Enter>')
    vim.keymap.set('n', 'q', ':q!<Enter>')
    vim.keymap.set('v', 'y', '"+y')
  end
})
