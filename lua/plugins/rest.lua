-- A very fast, powerful, extensible and asynchronous Neovim HTTP client written in Lua.

return {
  "rest-nvim/rest.nvim",
  -- The http treesitter parser it needs is installed in lua/plugins/treesitter.lua
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
