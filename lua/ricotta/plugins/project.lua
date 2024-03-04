return {
    "ahmedkhalf/project.nvim",
    -- dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    keys = {
        {
            "<leader>fp",
            "<Cmd>Telescope projects<CR>",
            desc = "[F]ind [P]rojects",
            silent = true,
            noremap = true,
        },
    },
    opts = {
        -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
        detection_methods = { "pattern" },
        -- patterns used to detect root dir, when **"pattern"** is in detection_methods
        patterns = { ".git" },
        -- Don't calculate root dir on specific directories
        exclude_dirs = {
            "/Users/rshrives",
        },
    },
    config = function(_, opts)
        require("project_nvim").setup(opts)
        require("telescope").load_extension("projects")
    end
}
