--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move stuff
vim.keymap.set("n", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("n", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<cr>")
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Keep cursor in position with J
vim.keymap.set("n", "J", "mzJ`z")

-- km.wk.register({ ["<leader>n"] = { name = " Notifications" } }, { mode = "n" })
-- km.nkeymap("<leader>nd", function()
-- 	require("notify").dismiss({})
-- end, "Dismiss notifications")

-- Smart splits FIXME
-- local splits = require("smart-splits")
-- Navigation
-- km.nkeymap("<C-h>", function()
-- 	splits.move_cursor_left()
-- end, "Move to left split")
-- km.nkeymap("<C-j>", function()
-- 	splits.move_cursor_down()
-- end, "Move to below split")
-- km.nkeymap("<C-k>", function()
-- 	splits.move_cursor_up()
-- end, "Move to above split")
-- km.nkeymap("<C-l>", function()
-- 	splits.move_cursor_right()
-- end, "Move to right split")

-- Resize
-- km.nkeymap("<A-k>", function()
-- 	splits.resize_up()
-- end, "Resize split up")
-- km.nkeymap("<A-j>", function()
-- 	splits.resize_down()
-- end, "Resize split down")
-- km.nkeymap("<A-h", function()
-- 	splits.resize_left()
-- end, "Resize split left")
-- km.nkeymap("<A-l", function()
-- 	splits.resize_right()
-- end, "Resize split right")
