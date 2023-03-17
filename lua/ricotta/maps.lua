-- Shorten function name
local keymap = vim.keymap.set

-- some options you'll always want to be true
local function opts(desc)
    return {
        desc = desc or "",
        noremap = true,
        silent = true,
    }
end
-- local term_opts = { silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts("Leader key"))
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
keymap("n", "<C-h>", "<C-w>h", opts("Move left one window"))
keymap("n", "<C-j>", "<C-w>j", opts("Move down one window"))
keymap("n", "<C-k>", "<C-w>k", opts("Move up one window"))
keymap("n", "<C-l>", "<C-w>l", opts("Move right one window"))
keymap("n", "<leader>h", "<cmd>wincmd h<CR>", opts("Move left one window"))
keymap("n", "<leader>j", "<cmd>wincmd j<CR>", opts("Move down one window"))
keymap("n", "<leader>k", "<cmd>wincmd k<CR>", opts("Move up one window"))
keymap("n", "<leader>l", "<cmd>wincmd l<CR>", opts("Move right one window"))
keymap("n", "<leader>o", "<cmd>wincmd o<CR>", opts("Make the current window the [o]nly one on the screen"))
keymap("n", "<leader>z", "<cmd>wincmd z<CR>", opts("Close netrw preview window"))
keymap("n", "<leader>x", vim.cmd.Ex, opts("E[x]plore directory"))
keymap("n", "<leader>w", vim.cmd.w, opts("[w]rite file"))
keymap("n", "<c-s>", vim.cmd.w, opts("[s]ave file"))
keymap("n", "<leader><leader>x", "<cmd>w<CR><cmd>so %<CR>", opts("Save and e[x]ecute file"))

-- Close buffers
-- keymap("n", "<leader>c", "<cmd>wincmd c<CR>", opts)
keymap("n", "<leader>c", vim.cmd.close, opts("[c]lose buffer"))

-- Resize with arrows
keymap("n", "<S-Up>", "<cmd>resize -2<CR>", opts("Increase horizontal size"))
keymap("n", "<S-Down>", "<cmd>resize +2<CR>", opts("Decrease horizontal size"))
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>", opts("Increase vertical size"))
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>", opts("Decrease vertical size"))

-- Navigate tabs
keymap("n", "<S-l>", vim.cmd.tabnext, opts("Move to the next tab"))
keymap("n", "<S-h>", vim.cmd.tabprevious, opts("Move to the previous tab"))

-- Center screen on jumping
keymap("n", "<C-d>", "<C-d>zz", opts("Jump [d]own half page"))
keymap("n", "<C-u>", "<C-u>zz", opts("Jump [u]p half page"))

-- Center screen on next match
keymap("n", "n", "nzzzv", opts("Go to [n]ext match"))
keymap("n", "N", "Nzzzv", opts("Go to [n]ext match backwards"))

-- Toggle spellcheck
keymap("n", "<leader>s", "<cmd>setlocal spell!<CR>", opts("Enable [s]pellcheck"))

-- Delete without yanking
keymap("n", "<leader>d", '"_d', opts("[d]elete without yanking"))
keymap("n", "x", '"_x', opts("Delete character without yanking"))


-- INSERT MODE --
-- Press jk fast to escape
keymap("i", "jk", "<ESC>", opts("Escape to normal mode"))

-- Ctrl-c to escape
keymap("i", "<C-c>", "<ESC>", opts("Escape"))

-- VISUAL MODE --

-- Stay in indent mode
keymap("v", "<", "<gv", opts("Indent selection left"))
keymap("v", ">", ">gv", opts("Indent selection right"))

-- Move text up and down
keymap("v", "<S-j>", ":m '>+1<CR>gv=gv", opts("Move selection up"))
keymap("v", "<S-k>", ":m '<-2<CR>gv=gv", opts("Move selection down"))

-- Perform dot commands over visual blocks
keymap("v", ".", "<cmd>normal .<CR>", opts("Repeat last action"))

-- Don't mess with my clipboard pls
keymap("x", "<leader>p", '"_dP', opts("[p]aste without yanking"))
