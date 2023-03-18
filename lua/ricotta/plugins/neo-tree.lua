return {
    "nvim-neo-tree/neo-tree.nvim",
    version = "v2.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = function()
        -- Unless you are still migrating, remove the deprecated commands from v1.x
        vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

        -- 
        vim.keymap.set("n", "\\", ":NeoTreeFocusToggle <CR>", {
            desc = "Toggle NeoTree",
            noremap = true,
            silent = true
        })
        vim.keymap.set("n", "<leader>x", ":NeoTreeFocusToggle <CR>", {
            desc = "E[x]plore director | Toggle NeoTree",
            noremap = true,
            silent = true
        })
    end
}
