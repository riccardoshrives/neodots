-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

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

-- vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'TextChanged', 'TextChangedI' }, {
--   desc = 'Set color column in active window',
--   group = vim.api.nvim_create_augroup('ricotta-color-column', { clear = true }),
--   callback = function()
--     local col = vim.api.nvim_win_get_width(0)
--
--     if col > 80 then
--       vim.opt_local.colorcolumn = 80
--     else
--       vim.opt_local.colorcolumn = 0
--     end
--   end,
-- })
