-- Gimme them au groups
local myCommands = vim.api.nvim_create_augroup("My Commands", { clear = true })

-- -- Remove statusline and tabline when in Alpha
-- vim.api.nvim_create_autocmd({ "User" }, {
--   pattern = { "AlphaReady" },
--   callback = function()
--     vim.cmd [[
--       set showtabline=0 | autocmd BufUnload <buffer> set showtabline=1
--       set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
--     ]]
--   end,
-- })

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- -- Use 2 tabs in some filetepes
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "lua", "javascript" },
--   callback = function()
--     -- vim.schedule(function()
--     --   print "Tabs changed to 2"
--     -- end)
--     vim.opt_local.shiftwidth = 2
--     vim.opt_local.tabstop = 2
--     vim.opt_local.softtabstop = 2
--   end,
--   desc = " Use 2 tabs for lua and js filetepes ",
--   group = myCommands,
-- })

-- -- Attemps to set yaml syntax highlighting for html files in Statamic
-- vim.api.nvim_create_autocmd({ "BufRead", "BufReadPost" }, {
--   pattern = { "*.html" },
--   callback = function()
--     local path = vim.fn.expand "<afile>:p"
--     if string.find(path, "TII%-Statamic/site/content") then
--       vim.schedule(function()
--         print "Statamic html file has been set as yaml"
--       end)
--       vim.opt_local.filetype = "yaml"
--     else
--     end
--   end,
--   desc = " Use yaml syntax for html files in Statamic ",
--   group = myCommands,
-- })

-- vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

-- Open help pages vertically
-- vim.cmd "autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif"
