return {
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            -- mini.ai — enhances some builtin textobjects
            require('mini.ai').setup()

            -- mini.bracketed — replaces vim unimpaired
            require('mini.bracketed').setup()

            -- mini.comment — replaces comment.nvim / commentary
            require('mini.comment').setup()

            -- mini.completion — autocompletion and signature help
            -- require('mini.completion').setup()

            -- mini.pairs — autopairs
            require('mini.pairs').setup()

            -- mini.sessions
            -- require('mini.sessions').setup()

            -- mini.starter — start screen
            -- local starter = require('mini.starter')
            -- starter.setup({
            --     items = {
            --         starter.sections.telescope(),
            --     },
            --     content_hooks = {
            --         starter.gen_hook.adding_bullet(),
            --         starter.gen_hook.aligning('center', 'center')
            --     }
            -- })

            -- mini.surround — replaces vim surround
            -- require('mini.surround').setup()

            -- mini.statusline — statusline module with opinionated default look
            -- require('mini.statusline').setup()
        end,
    },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
        config = function(_, opts)
            require("mini.indentscope").setup(opts)
        end,
    } }
