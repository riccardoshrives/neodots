local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Telescope
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use "nvim-lua/popup.nvim"
  use "nvim-telescope/telescope.nvim"
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  }
  use "sudormrfbin/cheatsheet.nvim"

  -- Neovim behaviour
  use "moll/vim-bbye"
  use "ahmedkhalf/project.nvim"
  use "akinsho/toggleterm.nvim"

  -- GUI
  use "kyazdani42/nvim-tree.lua"
  use "kyazdani42/nvim-web-devicons"
  use "riccardoshrives/nvim-transparent"
  use "goolord/alpha-nvim"
  use "nvim-lualine/lualine.nvim"
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  }

  -- Colorschemes
  use "folke/tokyonight.nvim"
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use "gruvbox-community/gruvbox"
  use "shaunsingh/solarized.nvim"
  use "overcache/NeoSolarized"
  use "EdenEast/nightfox.nvim"
  use "marko-cerovac/material.nvim"
  use "ChristianChiarulli/nvcode-color-schemes.vim"
  use {
    "sonph/onehalf",
    rtp = "vim",
  }

  -- Shortcuts, Optimizations, and Efficiencies
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "lewis6991/impatient.nvim"
  use "tpope/vim-surround"
  use "numToStr/Comment.nvim"
  use "tpope/vim-unimpaired"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "RRethy/vim-illuminate"
  use "lukas-reineke/indent-blankline.nvim"
  use "SmiteshP/nvim-navic"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use {
    "lewis6991/spellsitter.nvim",
    config = function()
      require("spellsitter").setup()
    end,
  }
  use "andymass/vim-matchup"

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- DAP
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "nvim-telescope/telescope-dap.nvim"
  use "theHamsta/nvim-dap-virtual-text"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
