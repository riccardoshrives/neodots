require("ricotta.options")
require("ricotta.maps")

-- Use Lazy for plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
require("lazy").setup({
    spec = {
        { import = "ricotta.plugins" }
    },
    defaults = {
        -- all plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the
        -- plugin that support versioning, have outdated releases, which may
        -- break your Neovim install.
        version = false, -- always use the latest git commit
    },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = {
        -- automatically check for plugin updates
        enabled = false
    }
})
