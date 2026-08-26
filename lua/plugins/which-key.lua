-- Useful plugin to show you pending keybinds

return {
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter' (`:help autocmd-events`)
  opts = {
    spec = {
      { "<leader>c", group = "[C]ode" },
      { "<leader>d", group = "[D]ocument" },
      { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      { "<leader>r", group = "[R]ename" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>w", group = "[W]orkspace" },
    },
  },
}
