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

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install your plugins here
require("lazy").setup({

        -- Telescope
        {
                "nvim-telescope/telescope.nvim", version = "0.1.1",
                -- or                            , branch = '0.1.x',
                dependencies = { { "nvim-lua/plenary.nvim" } }
        },
        {
                "nvim-telescope/telescope-fzf-native.nvim", -- Required by some grep functions in telescope
                build = "make"
        },

        -- Theming
        "riccardoshrives/nvim-transparent",
        {
                "rose-pine/neovim",
                name = "rose-pine",
                config = function(LazyPlugin)
                        require("rose-pine").setup()
                        vim.cmd("colorscheme rose-pine")
                end
        },
        "folke/tokyonight.nvim",
        "lunarvim/colorschemes", -- A bunch of colorschemes you can try out
        "lunarvim/darkplus.nvim",
        "gruvbox-community/gruvbox",
        "shaunsingh/solarized.nvim",
        "overcache/NeoSolarized",
        "EdenEast/nightfox.nvim",
        "marko-cerovac/material.nvim",
        "ChristianChiarulli/nvcode-color-schemes.vim",
        {
                "sonph/onehalf",
                config = function(plugin)
                        vim.opt.rtp:append(plugin.dir .. "vim")
                end
        },

        -- Treesitter
        {
                "nvim-treesitter/nvim-treesitter",
                build = function()
                        local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
                        ts_update()
                end,
        },

        -- LSP
        {
                'VonHeikemen/lsp-zero.nvim',
                branch = 'v1.x',
                dependencies = {
                        -- LSP Support
                        { 'neovim/nvim-lspconfig' }, -- Required
                        { 'williamboman/mason.nvim' }, -- Optional
                        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

                        -- Autocompletion
                        { 'hrsh7th/nvim-cmp' }, -- Required
                        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
                        { 'hrsh7th/cmp-buffer' }, -- Optional
                        { 'hrsh7th/cmp-path' }, -- Optional
                        { 'saadparwaiz1/cmp_luasnip' }, -- Optional
                        { 'hrsh7th/cmp-nvim-lua' }, -- Optional

                        -- Snippets
                        { 'L3MON4D3/LuaSnip' }, -- Required
                        { 'rafamadriz/friendly-snippets' }, -- Optional
                }
        },

        -- Convenience utilities
        "mbbill/undotree",
        {
                "akinsho/toggleterm.nvim",
                version = '*',
                config = function()
                        require("toggleterm").setup()
                end
        },
        {
                'numToStr/Comment.nvim',
                config = function()
                        require('Comment').setup()
                end
        },
        "tpope/vim-surround",
        "tpope/vim-unimpaired",
        "ahmedkhalf/project.nvim",
        "windwp/nvim-autopairs",
        {
                'sudormrfbin/cheatsheet.nvim',

                dependencies = {
                        { 'nvim-telescope/telescope.nvim' },
                        { 'nvim-lua/popup.nvim' },
                        { 'nvim-lua/plenary.nvim' },
                }
        },


})
