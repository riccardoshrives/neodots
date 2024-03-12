-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'ziontee113/icon-picker.nvim',
    config = function()
      require('icon-picker').setup { disable_legacy_commands = true }

      local opts = { noremap = true, silent = true }

      vim.keymap.set('n', '<Leader><Leader>i', '<cmd>IconPickerNormal<cr>', opts)
      vim.keymap.set('n', '<Leader><Leader>y', '<cmd>IconPickerYank<cr>', opts) --> Yank the selected icon into register
      -- vim.keymap.set('i', '<C-i>', '<cmd>IconPickerInsert<cr>', opts)
    end,
  },
}
