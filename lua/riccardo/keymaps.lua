-- Shorten function name
local keymap = vim.keymap.set

-- some options you'll always want to be true
local opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c",

--  NORMAL MODE --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>h", "<cmd>wincmd h<CR>", opts)
keymap("n", "<leader>j", "<cmd>wincmd j<CR>", opts)
keymap("n", "<leader>k", "<cmd>wincmd k<CR>", opts)
keymap("n", "<leader>l", "<cmd>wincmd l<CR>", opts)
keymap("n", "<leader>o", "<cmd>wincmd o<CR>", opts)
keymap("n", "<leader>z", "<cmd>wincmd z<CR>", opts)
-- keymap("n", "<leader>x", "<cmd>Ex<CR>", opts)
keymap("n", "<leader><CR>", "<cmd>Alpha<CR>", opts)
keymap("n", "<leader>w", "<cmd>w<CR>", opts)
keymap("n", "<leader><leader>x", "<cmd>w<CR><cmd>so %<CR>", opts)

-- Close buffers
-- keymap("n", "<leader>c", "<cmd>wincmd c<CR>", opts)
keymap("n", "<leader>c", "<cmd>close<CR>", opts)
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Resize with arrows
keymap("n", "<S-Up>", "<cmd>resize -2<CR>", opts)
keymap("n", "<S-Down>", "<cmd>resize +2<CR>", opts)
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>tabnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>tabprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", opts)

-- Center screen on next match
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Toggle spellcheck
keymap("n", "<leader>s", "<cmd>setlocal spell!<CR>", opts)

-- Delete without yanking
keymap("n", "<leader>d", '"_d', opts)
keymap("n", "x", '"_x', opts)

-- Telescope
keymap("n", "<leader>t", "<cmd>Telescope<CR>")
-- Naviagate buffers
-- keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
-- keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)

-- keymap("n", "<RightMouse>", "<cmd>Alpha<CR>", opts)

-- INSERT MODE --
-- Press jk fast to escape
keymap("i", "jk", "<ESC>", opts)

-- Ctrl-c to escape
keymap("i", "<C-c>", "<ESC>", opts)

-- VISUAL MODE --
-- Escape with jk
-- keymap("v", "jk", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<S-j>", "<cmd>m .+1<CR>==", opts)
keymap("v", "<S-k>", "<cmd>m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Perform dot commands over visual blocks
keymap("v", ".", "<cmd>normal .<CR>", opts)

-- Visual Block --
-- Escape with jk
-- keymap("x", "jk", "<ESC>", opts)

-- Move text up and down
keymap("x", "J", "<cmd>move '>+1<CR>gv-gv", opts)
keymap("x", "K", "<cmd>move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", "<cmd>move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", "<cmd>move '<-2<CR>gv-gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>x", "<cmd>NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", "<cmd>Telescope projects<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>en", "<cmd>Telescope find_files cwd=~/.config/nvim<CR>", opts)
keymap("v", "<leader>fw", "<cmd>Telescope grep_string<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Markdown preview
keymap("n", "<leader>md", "<Plug>MarkdownPreviewToggle", opts)

-- Cheatsheet
keymap("n", "<leader>?", ":Cheatsheet<CR>", opts)
