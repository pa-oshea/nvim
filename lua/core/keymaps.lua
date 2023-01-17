local km = require("core.utils.keymapper")

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

km.keymap("", "<Space>", "<Nop>")
km.nkeymap("<C-s>", "<cmd>w!<cr>", "Force write")

-- Move stuff
km.vkeymap("J", ":m '>+1<CR>gv=gv")
km.vkeymap("K", ":m '<-2<CR>gv=gv")

km.nkeymap("n", "nzzzv")
km.nkeymap("N", "Nzzzv")
km.nkeymap("<C-d>", "<C-d>zz")
km.nkeymap("<C-u>", "<C-u>zz")

km.ikeymap("<C-c>", "<Esc>")

-- Stay in indent mode
km.vkeymap("<", "<gv")
km.vkeymap(">", ">gv")
-- Symbols outline
km.nkeymap("<leader>o", "<cmd>SymbolsOutline<cr>", "Toggle symbol outline")

km.nkeymap("<leader>g0", "<cmd>DiffviewOpen HEAD<cr>", "Open diff view HEAD")
km.nkeymap("<leader>g1", "<cmd>DiffviewOpen HEAD^<cr>", "Open diff view HEAD^")
km.nkeymap("<leader>g2", "<cmd>DiffviewOpen HEAD^^<cr>", "Open diff view HEAD^^")
km.nkeymap("<leader>g3", "<cmd>DiffviewOpen HEAD^^^<cr>", "Open diff view HEAD^^^")
km.nkeymap("<leader>g4", "<cmd>DiffviewOpen HEAD^^^^<cr>", "Open diff view HEAD^^^^")

km.wk.register({ ["<leader>n"] = { name = " Notifications" } }, { mode = "n" })
km.nkeymap("<leader>nd", function()
	require("notify").dismiss({})
end, "Dismiss notifications")

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
