local km = require("user.utils.keymapper")
--Remap space as leader key
km.keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

km.nkeymap("<leader>;", "<cmd>Alpha<cr>", " Open alpha")

-- TODO key map to move the current line down, also one to duplicate the current line
-- Standard remaps
km.nkeymap("<leader>w", "<cmd>w<cr>", "Save")
km.nkeymap("<leader>q", function()
	require("user.utils.functions").smart_quit()
end, "Quit")
km.nkeymap("<leader>fn", "<cmd>enew<cr>", "New file")
km.nkeymap("<C-s>", "<cmd>w!<cr>", "Force write")
km.nkeymap("<C-q>", "<cmd>q!<cr>", "Force quit")
-- Better paste
-- km.vkeymap("p", '"_dP')
km.xkeymap("<leader>p", '"_dP')

-- Move stuff
km.vkeymap("J", ":m '>+1<CR>gv=gv")
km.vkeymap("K", ":m '<-2<CR>gv=gv")

km.nkeymap("n", "nzzzv")
km.nkeymap("N", "Nzzzv")
km.nkeymap("<C-d>", "<C-d>zz")
km.nkeymap("<C-u>", "<C-u>zz")

-- yank to system clipboard
km.nkeymap("<leader>y", '"+y')
km.vkeymap("<leader>y", '"+y')
km.nkeymap("<leader>Y", '"+Y')

km.ikeymap("<C-c>", "<Esc>")

km.nkeymap("<leader>u", "<cmd>UndotreeToggle<cr>", "Undo tree")

-- Stay in indent mode
km.vkeymap("<", "<gv")
km.vkeymap(">", ">gv")

-- Plugin managers
km.wk.register({ ["<leader>p"] = { name = "Plugin managers" } }, { mode = "n" })
km.nkeymap("<leader>pc", "<cmd>PackerCompile<cr>", "Packer compile")
km.nkeymap("<leader>pi", "<cmd>PackerInstall<cr>", "Packer install")
km.nkeymap("<leader>ps", "<cmd>PackerSync<cr>", "Packer sync")
km.nkeymap("<leader>pS", "<cmd>PackerStatus<cr>", "Packer status")
km.nkeymap("<leader>pu", "<cmd>PackerUpdate<cr>", "Packer update")

km.nkeymap("<leader>pI", "<cmd>Mason<cr>", "Mason installer")
km.nkeymap("<leader>pU", "<cmd>MasonUpdateAll<cr>", "Mason update")

-- Naviage buffers
km.nkeymap("<S-l>", "<cmd>BufferLineCycleNext<cr>", "Next buffer tab")
km.nkeymap("<S-h>", "<cmd>BufferLineCyclePrev<cr>", "Previous buffer tab")
km.nkeymap(">b", "<cmd>BufferLineMoveNext<cr>", "Move buffer tab right")
km.nkeymap("<b", "<cmd>BufferLineMovePrev<cr>", "Move buffer tab left")

-- Deleting buffers
km.nkeymap("<leader>c", function()
	require("bufdelete").bufdelete(0, false)
end, "Close buffer")

km.nkeymap("<leader>C", function()
	require("bufdelete").bufdelete(0, true)
end, "Force close buffer")

-- Smart splits FIXME
local splits = require("smart-splits")
-- Navigation
km.nkeymap("<C-h>", function()
	splits.move_cursor_left()
end, "Move to left split")
km.nkeymap("<C-j>", function()
	splits.move_cursor_down()
end, "Move to below split")
km.nkeymap("<C-k>", function()
	splits.move_cursor_up()
end, "Move to above split")
km.nkeymap("<C-l>", function()
	splits.move_cursor_right()
end, "Move to right split")

-- Resize
km.nkeymap("<A-k>", function()
	splits.resize_up()
end, "Resize split up")
km.nkeymap("<A-j>", function()
	splits.resize_down()
end, "Resize split down")
km.nkeymap("<A-h", function()
	splits.resize_left()
end, "Resize split left")
km.nkeymap("<A-l", function()
	splits.resize_right()
end, "Resize split right")

-- Plugins --
-- Telescope
km.wk.register({ ["<leader>f"] = { name = " Telescope" } }, { mode = "n" })
km.nkeymap("<leader>ff", "<cmd>Telescope find_files<cr>", "Find file")
km.nkeymap("<leader>fb", "<cmd>Telescope buffers<cr>", "Browse buffers")
km.nkeymap("<leader>fg", "<cmd>Telescope live_grep<cr>", "Live grep")
km.nkeymap("<leader>fa", "<cmd>Telescope git_files<cr>", "Find git files")
km.nkeymap("<leader>fp", "<cmd>Telescope projects<cr>", "Browse projects")
km.nkeymap("<leader>fr", "<cmd>Telescope lsp_references<cr>", "Browse references")
km.nkeymap("<leader>fh", "<cmd>Telescope help_tags<cr>", "Help tags")

-- Notify
km.wk.register({ ["<leader>n"] = { name = " Notifications" } }, { mode = "n" })
km.nkeymap("<leader>nd", function()
	require("notify").dismiss()
end, "Dismiss notifications")
km.nkeymap("<leader>nl", function()
	require("telescope").extensions.notify.notify()
end, "List notifications")

-- NvimTree
km.nkeymap("<leader>e", ":NvimTreeToggle<CR>", "Open nvim tree")

-- Git
km.wk.register({ ["<leader>g"] = { name = " Git" } }, { mode = "n" })
km.nkeymap("<leader>gb", "<cmd>Gitsigns blame_line<cr>", " Blame line")
km.nkeymap("<leader>g]", "<cmd>Gitsigns next_hunk<cr>", " Next hunk")
km.nkeymap("<leader>g[", "<cmd>Gitsigns prev_hunk<cr>", " Prev hunk")
km.nkeymap("<leader>g?", "<cmd>Gitsigns preview_hunk<cr>", " Preview changes")
km.nkeymap("<leader>go", "<cmd>DiffviewOpen<cr>", "Open diff view")
km.nkeymap("<leader>gc", "<cmd>DiffviewClose<cr>", "Close diff view")
km.nkeymap("<leader>gr", "<cmd>DiffviewRefresh<cr>", "Refresh diff view")
km.nkeymap("<leader>g0", "<cmd>DiffviewOpen HEAD<cr>", "Open diff view HEAD")
km.nkeymap("<leader>g1", "<cmd>DiffviewOpen HEAD^<cr>", "Open diff view HEAD^")
km.nkeymap("<leader>g2", "<cmd>DiffviewOpen HEAD^^<cr>", "Open diff view HEAD^^")
km.nkeymap("<leader>g3", "<cmd>DiffviewOpen HEAD^^^<cr>", "Open diff view HEAD^^^")
km.nkeymap("<leader>g4", "<cmd>DiffviewOpen HEAD^^^^<cr>", "Open diff view HEAD^^^^")

-- Toggle term
km.nkeymap("<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Open lazygit")
km.nkeymap("<leader>bb", "<cmd>lua _BPYTOP_TOGGLE()<CR>", "Open bpytop")

-- Symbols outline
km.nkeymap("<leader>o", "<cmd>SymbolsOutline<cr>", "Toggle symbol outline")

-- Comment
km.nkeymap("<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Comment line")
km.xkeymap(
	"<leader>/",
	'<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
	"Comment block"
)

-- Terminal
km.wk.register({ ["<leader>\\"] = { name = " Term Split" } })
km.nkeymap("<leader>\\v", "<cmd>vs<cr><cmd>terminal<cr>", "ﲖ Vertical")
km.nkeymap("<leader>\\h", "<cmd>sp<cr><cmd>terminal<cr>", "ﲐ Horizontal")

-- Trouble
km.wk.register({ ["<leader>x"] = { name = "Trouble" } }, { mode = "n" })
km.nkeymap("<leader>xx", "<cmd>TroubleToggle<cr>", "Trouble toggle")
km.nkeymap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble workspace diagnostics")
km.nkeymap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble document diagnostics")
km.nkeymap("<leader>xl", "<cmd>TroubleToggle loclist<cr>", "Trouble loclist")
km.nkeymap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>", "Trouble quickfix")

-- DAP
km.wk.register({ ["<leader>d"] = { name = "Dap" } }, { mode = "n" })
km.nkeymap("<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle break point")
km.nkeymap("<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Set conditional breakpoint")
km.nkeymap("<leader>dc", "<cmd>lua require'dap'.continue()<cr>", "Continue")
km.nkeymap("<leader>di", "<cmd>lua require'dap'.step_into()<cr>", "Step into")
km.nkeymap("<leader>do", "<cmd>lua require'dap'.step_over()<cr>", "Step over")
km.nkeymap("<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", "Step out")
km.nkeymap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl toggle")
km.nkeymap("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", "Run last")
km.nkeymap("<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", "Dap ui toggle")
km.nkeymap("<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", "Terminate")

-- Help
km.wk.register({ ["<leader>h"] = { name = "Help" } }, { mode = "n" })
km.nkeymap("<leader>hm", "<cmd>nmap<cr>", "Show key maps")
km.nkeymap("<leader>hf", "<cmd>Telescope keymaps<cr>", "Show key maps")
