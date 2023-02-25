local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    prompt_prefix = " ",
    selection_caret = " ",
    -- Format path as "file.txt (path\to\file\)"
    path_display = function(opts, path)
      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s (%s)", tail, path)
    end,
    file_ignore_patterns = { ".git/", "node_modules" },

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["q"] = actions.close,
      },
    },
  },
}

telescope.load_extension "fzf"

-- Keymaps for telescope

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
