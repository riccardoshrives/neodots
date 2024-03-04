return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    keys = {
        {
            "<S-Enter>",
            function() require("noice").redirect(vim.fn.getcmdline()) end,
            mode = "c",
            desc = "Redirect Cmdline"
        },
        {
            "<leader>snl",
            function() require("noice").cmd("last") end,
            desc = "Noice Last Message"
        },
        {
            "<leader>snh",
            function() require("noice").cmd("history") end,
            desc = "Noice History"
        },
        {
            "<leader>sna",
            function() require("noice").cmd("all") end,
            desc = "Noice All"
        },
        {
            "<leader>snd",
            function() require("noice").cmd("dismiss") end,
            desc = "Dismiss All"
        },
        {
            "<c-f>",
            function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
            silent = true,
            expr = true,
            desc = "Scroll forward",
            mode = { "i", "n", "s" }
        },
        {
            "<c-b>",
            function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
            silent = true,
            expr = true,
            desc = "Scroll backward",
            mode = { "i", "n", "s" }
        },
    },
    opts = {
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
            long_message_to_split = true,
        },
    },
    config = function(_, opts)
        require("noice").setup(opts)

        require("notify").setup({
            background_colour = "#000000",
        })
    end,
}
