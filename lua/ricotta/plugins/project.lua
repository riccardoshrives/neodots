return {
    "ahmedkhalf/project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim"},
    config = function()
        require("project_nvim").setup {
            -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
            detection_methods = { "pattern" },

            -- patterns used to detect root dir, when **"pattern"** is in detection_methods
            patterns = { ".git" },

            -- Don't calculate root dir on specific directories
            exclude_dirs = {
                "/Users/rshrives",
            },
        }

        -- Use telescope to browse projects
        require("telescope").load_extension "projects"
        vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", {
            desc = "[F]ind [P]rojects",
            silent = true,
            noremap = true
        })
    end
}
