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

vim.lsp.config['typescript-lsp'] = {
  filetypes= { 'typescript' },
  cmd = { 'typescript-language-server --stdio' },
  root_markers = { 'tsconfig.json' },
  settings = { },
}

-- require("typescript-tools").setup {
--   settings = {
--     tsserver_file_preferences = {
--       includeInlayParameterNameHints = "all",
--       includeCompletionsForModuleExports = true,
--       quotePreference = "auto",
--       ...
--     },
--     tsserver_format_options = {
--       allowIncompleteCompletions = false,
--       allowRenameOfImportPath = false,
--       ...
--     }
--   },
-- }

vim.cmd("source ~/scripts/common.vim")
-- vim.cmd("source ~/.config/work.vim")

vim.cmd("au TermOpen * set nonumber")
vim.cmd("au TermOpen * set norelativenumber")
vim.cmd("au TermOpen * echo 'HI!!'")


vim.cmd("set relativenumber")
vim.cmd("set number")


vim.cmd("call plug#begin('~/.vim/bundle')")
vim.cmd("Plug 'mikesmithgh/kitty-scrollback.nvim'")
vim.cmd("call plug#end()")

require('kitty-scrollback').setup()
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
