-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  desc = 'Open help pages vertically',
  group = vim.api.nvim_create_augroup('ricotta-help-vsplit', { clear = true }),
  pattern = { 'help', 'man' },
  callback = function()
    vim.cmd.wincmd 'L'
    vim.opt_local.winwidth = 82
  end,
})
