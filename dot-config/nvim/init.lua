
vim.cmd('source ~/scripts/configs/nvimrc.vim')
vim.opt.signcolumn = "yes"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.print(vim.inspect("starting rubocop"))
    vim.lsp.start {
      name = "rubocop",
      cmd = { "bundle", "exec", "rubocop", "--lsp" },
    }
    vim.print(vim.inspect("started rubocop"))
  end,
})

vim.cmd("source ~/scripts/common.vim")
-- vim.cmd("source ~/.config/work.vim")

vim.cmd("au TermOpen * set nonumber")
vim.cmd("au TermOpen * set norelativenumber")
vim.cmd("au TermOpen * echo 'HI!!'")


vim.cmd("set relativenumber")
-- KwsNumbering = function()
--   if posix.stat("/tmp/vim-numbering") then
--   else
--     vim.cmd("set norelativenumber")
--   end
-- end

-- vim.api.nvim_create_autocmd("FocusLost", {
--   pattern = "*",
--   callback = KwsNumbering
-- })
-- vim.api.nvim_create_autocmd("FocusGained", {
--   pattern = "*",
--   callback = KwsNumbering
-- })
