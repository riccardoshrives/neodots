return { -- Theming
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
    }
}
