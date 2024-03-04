return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            -- Required by some grep functions in telescope
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                -- To get fzf loaded and working with telescope, you need to call
                -- load_extension, somewhere after setup function:
                require("telescope").load_extension("fzf")
            end
        },
        {
            -- for browsing files
            "nvim-telescope/telescope-file-browser.nvim",
            config = function()
                -- To get file_browser loaded and working with telescope, you need to call
                -- load_extension, somewhere after setup function:
                require("telescope").load_extension("file_browser")
            end
        },

    },
    keys = {
        {
            '<leader>t',
            require("telescope.builtin").builtin,
            noremap = true,
            silent = true,
            desc = "[T]elescope"
        },
        {
            '<leader>pf',
            require("telescope.builtin").git_files,
            noremap = true,
            silent = true,
            desc = "[P]roject [F]iles"
        },
        {
            '<leader>ff',
            require("telescope.builtin").find_files,
            noremap = true,
            silent = true,
            desc = "[F]ind [F]iles"
        },
        {
            '<leader>fg',
            require("telescope.builtin").live_grep,
            noremap = true,
            silent = true,
            desc = "[F]ind via [G]rep"
        },
        {
            '<leader>fb',
            require("telescope.builtin").buffers,
            noremap = true,
            silent = true,
            desc = "[F]ind [B]uffers"
        },
        { '<leader>fh', require("telescope.builtin").help_tags, { noremap = true, silent = true, desc = "[F]ind [H]elp" } },
        {
            '<leader>fo',
            require("telescope.builtin").oldfiles,
            noremap = true,
            silent = true,
            desc = "[F]ind [O]ldfiles"
        },
        {
            '<leader>fx',
            ":Telescope file_browser <CR>",
            noremap = true,
            silent = true,
            desc = "[F]ile E[x]plorer"
        },
        {
            '<leader>ps',
            function()
                require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
            end,
            noremap = true,
            silent = true,
            desc = "[P]roject [S]earch"
        }
    },
    opts = {
        defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value
            mappings = {
                i = {
                    ["<Down>"] = require("telescope.actions").cycle_history_next,
                    ["<Up>"] = require("telescope.actions").cycle_history_prev,
                    ["<C-j>"] = require("telescope.actions").move_selection_next,
                    ["<C-k>"] = require("telescope.actions").move_selection_previous,
                },
                n = {
                    ["q"] = require("telescope.actions").close,
                },
            },
            prompt_prefix = " ",
            selection_caret = " ",
            -- Format path as "file.txt (path\to\file\)"
            path_display = function(opts, path)
                local tail = require("telescope.utils").path_tail(path)
                return string.format("%s (%s)", tail, path)
            end,
            file_ignore_patterns = { ".git/", "node_modules" },
            -- theme = "ivy",
        },
        pickers = {
            colorscheme = {
                enable_preview = true
            }
        },
    },
    -- config = function()
    --     require("telescope").setup()
    -- end
}
