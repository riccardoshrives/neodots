return {
    "nvim-neo-tree/neo-tree.nvim",
    version = "v2.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        {
            "\\",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
            end,
            desc = "Toggle NeoTree",
            noremap = true,
            silent = true
        },
        {
            "<leader>x",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
            end,
            desc = "E[x]plore director | Toggle NeoTree",
            noremap = true,
            silent = true
        }
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    init = function()
        -- Unless you are still migrating, remove the deprecated commands from v1.x
        vim.g.neo_tree_remove_legacy_commands = 1
        if vim.fn.argc() == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argc(0))
            if stat and stat.type == "directory" then
                require "neo-tree"
            end
        end
    end,
    config = function()
        require("neo-tree").setup({
            filesystem = {
                hijack_netrw_behavior = "open_current",
            }
        })
   end
}
