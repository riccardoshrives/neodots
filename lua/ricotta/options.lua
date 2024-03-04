local options = {
    backspace = "indent,eol,start",                -- make the backspace key work properly
    backup = false,                                -- do not use vim backups
    bri = true,                                    -- preserve indentation in wrapped text
    completeopt = "menu,menuone,noselect",         -- whether to use a popup menu for Insert mode completion
    clipboard = vim.opt.clipboard + "unnamedplus", -- use system clipboard
    cpo = vim.opt.cpo + "n",                       -- When included, the column used for 'number' and 'relativenumber' will also be used for text of wrapped lines.
    cursorline = true,                             -- where tf is my cursor?
    errorbells = false,                            -- shut up
    expandtab = true,                              -- converts tabs to spaces
    exrc = true,                                   -- checks if there is a specific config / vimrc
    fileencoding = "utf-8",                        -- the encoding written to a file
    foldcolumn = "auto",                           -- width of the column used to indicate folds
    foldmethod = "manual",                         -- set default fold type
    hidden = true,                                 -- hide buffers instead of closing
    hlsearch = false,                              -- remove highlight when I'm done searching
    ignorecase = true,                             -- ignore case when using a search pattern
    incsearch = true,                              -- show matches as I am searching
    isfname = vim.opt.isfname + "@-@",             -- include more characters in file names
    mouse = "a",                                   -- enable mouse support
    number = true,                                 -- set numbered lines
    pumheight = 10,                                -- pop up menu height
    relativenumber = true,                         -- set relative numbered lines
    scrolloff = 10,                                -- how many lines before the end of the page to start scrolling
    shortmess = vim.opt.shortmess + "c",           -- Don't pass messages to ins-completion-menu
    sidescrolloff = 8,                             -- same as scrolloff but for the sides
    signcolumn = "yes",                            -- always show the sign column, otherwise the text would shift each time
    shiftwidth = 4,                                -- number of spaces inserted for each indentation
    showmode = false,                              -- we no longer need to display the current mode in the msg area
    smartcase = true,                              -- override 'ignorcase' when pattern has upper case characters
    softtabstop = 4,                               -- number of spaces in a softtab
    splitbelow = true,                             -- a new window is put below the current one
    splitright = true,                             -- a new window is put right of the current one
    smartindent = true,                            -- make indenting smarter again
    swapfile = false,                              -- use buffers without swapfiles
    tabstop = 4,                                   -- number of spaces in a tab
    termguicolors = true,                          -- enable 24-bit RGB color, use term gui colors
    timeoutlen = 500,                              -- Time in milliseconds to wait for a mapped sequence to complete.
    undofile = true,                               -- create an undo file instead
    wildmenu = true,                               -- command-line completions shows a list of matches
    -- winbar = "%h%m %{%v:lua.require'nvim-navic'.get_location()%}%=%f", -- customize winbar
    wrap = false,                                  -- whether to wrap long lines
}

for key, value in pairs(options) do
    vim.opt[key] = value
end

-- put those undo fles in this directory
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir/"
