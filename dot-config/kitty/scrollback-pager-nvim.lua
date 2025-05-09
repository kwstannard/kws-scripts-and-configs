vim.opt.encoding='utf-8'

vim.cmd("call plug#begin('~/.vim/bundle')")
vim.cmd("Plug 'valeratrades/AnsiEsc'")
vim.cmd("call plug#end()")

vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    callback = function(args)
      vim.cmd("echo 'HELLO WOLF'")
      vim.cmd("AnsiEsc")
      vim.cmd("silent! %s/(B//g")
      vim.cmd("silent! %s/]133;A//g")
      -- vim.cmd("silent! %s/\\//g")
      vim.opt.readonly = true
      vim.opt.write = false
      vim.opt.modifiable = false
      vim.keymap.set('n', 'ZZ', ':q!<Enter>')
      vim.keymap.set('n', 'q', ':q!<Enter>')
      vim.keymap.set('v', 'y', '"+y')
    end
  })
