-- visualize undo history and easily browse and switch between different undo branches

return {
  'mbbill/undotree',

  config = function()
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndotree toggle' })
  end,
}
