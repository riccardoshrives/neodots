return {
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup {
            check_ts = true, -- treesitter integration
            disable_filetype = { "TelescopePrompt" },
            fast_wrap = {
                map = '<leader><leader>w',
            },
        }

        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
    end
}
