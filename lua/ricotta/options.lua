local options = {
  exrc = true, -- checks if there is a specific config / vimrc
  mouse = "a", -- enable mouse support
  hidden = true, -- hide buffers instead of closing
  swapfile = false, -- use buffers without swapfiles
  backup = false, -- do not use vim backups
  undofile = true, -- create an undo file instead
  undodir = "~/.vim/undodir/", -- put those undo fles in this directory
  fileencoding = "utf-8", -- the encoding written to a file
  errorbells = false, -- shut up
  splitbelow = true, -- a new window is put below the current one
  splitright = true, -- a new window is put right of the current one
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  signcolumn = "yes", -- always show the sign column, otherwise the text would shift each time
  cursorline = true, -- where tf is my cursor?
  termguicolors = true, -- enable 24-bit RGB color, use term gui colors
  incsearch = true, -- show matches as I am searching
  hlsearch = false, -- remove highlight when I'm done searching
  expandtab = true, -- converts tabs to spaces
  tabstop = 4, -- number of spaces in a tab
  softtabstop = 4, -- number of spaces in a softtab
  shiftwidth = 4, -- number of spaces inserted for each indentation
  smartindent = true, -- make indenting smarter again
  bri = true, -- preserve indentation in wrapped text
  wrap = false, -- whether to wrap long lines
  scrolloff = 10, -- how many lines before the end of the page to start scrolling
  sidescrolloff = 8, -- same as scrolloff but for the sides
  foldcolumn = "auto", -- width of the column used to indicate folds
  foldmethod = "marker", -- set default fold type
  ignorecase = true, -- ignore case when using a search pattern
  smartcase = true, -- override 'ignorcase' when pattern has upper case characters
  wildmenu = true, -- command-line completions shows a list of matches
  completeopt = "menu,menuone,noselect", -- whether to use a popup menu for Insert mode completion
  pumheight = 10, -- pop up menu height
  showmode = false, -- we no longer need to display the current mode in the msg area
  -- winbar = "%h%m %{%v:lua.require'nvim-navic'.get_location()%}%=%f", -- customize winbar
  clipboard = vim.opt.clipboard + "unnamedplus", -- use system clipboard
  isfname = vim.opt.isfname + "@-@", -- include more characters in file names
  shortmess = vim.opt.shortmess + "c", -- Don't pass messages to ins-completion-menu
  timeoutlen = 500, -- Time in milliseconds to wait for a mapped sequence to complete.
  cpo = vim.opt.cpo + "n", -- When included, the column used for 'number' and 'relativenumber' will also be used for text of wrapped lines.
}

for key, value in pairs(options) do
  vim.opt[key] = value
end
