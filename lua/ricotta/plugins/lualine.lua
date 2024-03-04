return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        local function fg(name)
            ---@type {foreground?:number}?
            local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or
                vim.api.nvim_get_hl_by_name(name, true)
            local fg = hl and hl.fg or hl.foreground
            return fg and { fg = string.format("#%06x", fg) }
        end

        require("lualine").setup({
            options = {
                globalstatus = true,
                section_separators = { left = '', right = '' },
                component_separators = '|',
                disabled_filetypes = { -- Filetypes to disable lualine for.
                    'alpha',
                    'TelescopePrompt',
                    'dashboard',
                    'fzf',
                },
            },
            extensions = { "neo-tree", "lazy" },
            -- sections = {
            --     lualine_x = {
            --         -- stylua: ignore
            --         {
            --             function() return require("noice").api.status.command.get() end,
            --             cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            --             color = fg("Statement"),
            --         }, -- stylua: ignore
            --         {
            --             function() return require("noice").api.status.mode.get() end,
            --             cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            --             color = fg("Constant"),
            --         },
            --     }
            -- }
        })
    end
}
