--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap

-- Moving text
map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = false })
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = false })

-- Keep centered when page up and down
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = false })
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = false })

-- Move stuff
map("n", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = false })
map("n", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = false })

-- Searching centering
map("n", "n", "nzzzv", { noremap = true, silent = false })
map("n", "N", "Nzzzv", { noremap = true, silent = false })

map("n", "Q", "<nop>", { noremap = true, silent = false })
map("i", "<C-c>", "<Esc>", { noremap = true, silent = false })

-- Stay in indent mode
map("v", "<", "<gv", { noremap = true, silent = false })
map("v", ">", ">gv", { noremap = true, silent = false })
