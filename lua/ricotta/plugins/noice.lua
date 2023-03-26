return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            messages = {
                view_search = false, -- view for search count messages. Set to `false` to disable
            },
            lsp = {
                override = {
                    -- override markdown rendering so that cmp and other plugins use Treesitter
                    -- override the default lsp markdown formatter with Noice
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    -- override the lsp markdown formatter with Noice
                    ["vim.lsp.util.stylize_markdown"] = true,
                    -- override cmp documentation with Noice (needs the other options to work)
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                command_palette = true, -- position the cmdline and popupmenu together
            },
        })

        require("notify").setup({
            background_colour = "#000000",
        })
    end,
}
