return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.1",
    -- or                            , branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            -- Required by some grep functions in telescope
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
        },
        "nvim-telescope/telescope-file-browser.nvim", -- for browsing files

    },
    config = function()
        require("telescope").setup({
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

            },
            pickers = {
                colorscheme = {
                    enable_preview = true
                }
            },
        })
        -- To get fzf loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require("telescope").load_extension("fzf")

        -- To get file_browser loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require("telescope").load_extension("file_browser")

        -- Keymaps for telescope
        local opts = function(desc)
            return {
                desc = desc,
                noremap = true,
                silent = true
            }
        end
        local builtin = require('telescope.builtin')
        -- vim.keymap.set('n', '<leader>t', '<cmd>Telescope<CR>', opts)
        vim.keymap.set('n', '<leader>t', builtin.builtin, opts("[T]elescope"))
        vim.keymap.set('n', '<leader>pf', builtin.git_files, opts("[P]roject [F]iles"))
        vim.keymap.set('n', '<leader>ff', builtin.find_files, opts("[F]ind [F]iles"))
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts("[F]ind via [G]rep"))
        vim.keymap.set('n', '<leader>fb', builtin.buffers, opts("[F]ind [B]uffers"))
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts("[F]ind [H]elp"))
        vim.keymap.set('n', '<leader>fx', ":Telescope file_browser <CR>", opts("[F]ile E[x]plorer"))
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, opts("[P]roject [S]earch"))
    end
}
