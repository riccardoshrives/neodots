return {
    "akinsho/toggleterm.nvim",
    version = '*',
    config = function()
        require("toggleterm").setup({
            size = 15,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_terminals = false,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
            },
        })
        -- Keymaps to make moving in and out of a terminal easier once toggled, while still keeping it open
        function _G.set_terminal_keymaps()
            local opts = { noremap = true }
            -- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
            -- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
            vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
            vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
            vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
        end

        vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

        vim.keymap.set("n", "<leader>\\", ":ToggleTerm size=10 direction=float <CR>",
            { desc = "ToggleTerm float", noremap = true, silent = true })

        -- Use toggleterm for LazyGit!
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit  = Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float",
            on_open = function()
                vim.keymap.set("n", "<esc>", "<cmd>close<CR>", { noremap = true, silent = true })
            end
        })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        vim.keymap.set("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>",
            { desc = "Lazy[G]it", noremap = true, silent = true })

        -- Use toggleterm for live-server
        local liveServer = Terminal:new({
            -- dir = "%:h",
            cmd = "live-server",
        })

        function _liveServer_toggle()
            liveServer:toggle()
        end

        vim.keymap.set("n", "<leader>ls", "<cmd>lua _liveServer_toggle()<CR>",
            { desc = "[L]ive [S]erver", noremap = true, silent = true })
    end
}
