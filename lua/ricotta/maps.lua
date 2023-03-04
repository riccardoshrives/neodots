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
keymap("n", "<leader>x", vim.cmd.Ex, opts)
keymap("n", "<leader>w", vim.cmd.w, opts)
keymap("n", "<c-s>", vim.cmd.w, opts)
keymap("n", "<leader><leader>x", "<cmd>w<CR><cmd>so %<CR>", opts)

-- Close buffers
-- keymap("n", "<leader>c", "<cmd>wincmd c<CR>", opts)
keymap("n", "<leader>c", vim.cmd.close, opts)

-- Resize with arrows
keymap("n", "<S-Up>", "<cmd>resize -2<CR>", opts)
keymap("n", "<S-Down>", "<cmd>resize +2<CR>", opts)
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Navigate tabs
keymap("n", "<S-l>", vim.cmd.tabnext, opts)
keymap("n", "<S-h>", vim.cmd.tabprevious, opts)

-- Center screen on jumping
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Center screen on next match
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Toggle spellcheck
keymap("n", "<leader>s", "<cmd>setlocal spell!<CR>", opts)

-- Delete without yanking
keymap("n", "<leader>d", '"_d', opts)
keymap("n", "x", '"_x', opts)


-- INSERT MODE --
-- Press jk fast to escape
keymap("i", "jk", "<ESC>", opts)

-- Ctrl-c to escape
keymap("i", "<C-c>", "<ESC>", opts)

-- VISUAL MODE --

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<S-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<S-k>", ":m '<-2<CR>gv=gv", opts)

-- Perform dot commands over visual blocks
keymap("v", ".", "<cmd>normal .<CR>", opts)

-- Don't mess with my clipboard pls
keymap("x", "<leader>p", '"_dP', opts)

-- Lazygit
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
