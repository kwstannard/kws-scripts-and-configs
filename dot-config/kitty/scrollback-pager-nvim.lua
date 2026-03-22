vim.opt.encoding='utf-8'

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
