return { -- Theming
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require("rose-pine").setup()
            vim.cmd("colorscheme rose-pine")
        end
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                style = "night",
                transparent = true,
                dim_inactive = true,
                on_highlights = function(hl, c)
                    local prompt = "#2d3149"
                    hl.TelescopeNormal = {
                        bg = c.bg_dark,
                        fg = c.fg_dark,
                    }
                    hl.TelescopeBorder = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    hl.TelescopePromptNormal = {
                        bg = prompt,
                    }
                    hl.TelescopePromptBorder = {
                        bg = prompt,
                        fg = prompt,
                    }
                    hl.TelescopePromptTitle = {
                        -- bg = prompt,
                        -- fg = c.fg_dark,
                    }
                    hl.TelescopePreviewTitle = {
                        -- bg = c.bg_dark,
                        -- fg = c.fg_dark,
                    }
                    hl.TelescopeResultsTitle = {
                        -- bg = c.bg_dark,
                        -- fg = c.fg_dark,
                    }
                end,
            })
        end
    },
    {
        "sonph/onehalf",
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "vim")
        end
    },
    "lunarvim/colorschemes", -- A bunch of colorschemes you can try out
    "lunarvim/darkplus.nvim",
    "gruvbox-community/gruvbox",
    "shaunsingh/solarized.nvim",
    "overcache/NeoSolarized",
    "EdenEast/nightfox.nvim",
    "marko-cerovac/material.nvim",
    "ChristianChiarulli/nvcode-color-schemes.vim",
    "sainnhe/gruvbox-material",
}
