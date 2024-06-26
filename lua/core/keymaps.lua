-- DESCRIPTION:
-- All mappings are defined here.

--    Sections:
--
--       ## Base bindings
--       -> icons displayed on which-key.nvim
--       -> standard operations
--       -> clipboard
--       -> search highlighting
--       -> improved tabulation
--       -> improved gg
--       -> packages
--       -> buffers/tabs                       [buffers]
--       -> ui toggles                         [ui]
--       -> shifted movement keys
--       -> cmdline autocompletion
--       -> special cases

--       ## Plugin bindings
--       -> alpha-nvim
--       -> comments.nvim
--       -> git                                [git]
--       -> file browsers
--       -> smart-splits.nvim
--       -> aerial.nvim
--       -> telescope.nivm                     [find]
--       -> toggleterm.nvim
--       -> dap.nvim                           [debugger]
--       -> tests                              [tests]
--       -> nvim-ufo
--       -> code documentation                 [docs]
--       -> ask chatgpt                        [neural]
--       -> hop.nvim
--       -> mason-lspconfig.nvim               [lsp]

--
--   KEYBINDINGS REFERENCE
--   -------------------------------------------------------------------
--   |        Mode  | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang |
--   Command        +------+-----+-----+-----+-----+-----+------+------+
--   [nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
--   n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
--   [nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
--   i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
--   c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
--   v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
--   x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
--   s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
--   o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
--   t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
--   l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |
--   -------------------------------------------------------------------

local M = {}
local utils = require("core.utils")
local get_icon = utils.get_icon
local is_available = utils.is_available
local ui = require("core.utils.ui")
local maps = require("core.utils").get_mappings_template()

-- -------------------------------------------------------------------------
--
-- ## Base bindings ########################################################
--
-- -------------------------------------------------------------------------

-- icons displayed on which-key.nvim ---------------------------------------
local icons = {
	s = { desc = get_icon("Search", 1, true) .. "Search" },
	p = { desc = get_icon("Package", 1, true) .. "Packages" },
	l = { desc = get_icon("ActiveLSP", 1, true) .. "LSP" },
	u = { desc = get_icon("Window", 1, true) .. "UI" },
	b = { desc = get_icon("Tab", 1, true) .. "Buffers" },
	bs = { desc = get_icon("Sort", 1, true) .. "Sort Buffers" },
	c = { desc = get_icon("Run", 1, true) .. "Compiler" },
	d = { desc = get_icon("Debugger", 1, true) .. "Debugger" },
	tt = { desc = get_icon("Test", 1, true) .. "Test" },
	dc = { desc = get_icon("Docs", 1, true) .. "Docs" },
	g = { desc = get_icon("Git", 1, true) .. "Git" },
	S = { desc = get_icon("Session", 1, true) .. "Session" },
	t = { desc = get_icon("Terminal", 1, true) .. "Terminal" },
	x = { desc = get_icon("Diagnostics", 1, true) .. "Trouble" },
	gd = { desc = get_icon("GitConflict", 1, true) .. "Diff view" },
}

-- standard Operations -----------------------------------------------------
maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" }
maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" }
maps.n["<leader>v"] = {
	function()
		vim.cmd("UndotreeToggle")
	end,
	desc = "Undo tree",
}
maps.n["gx"] = { utils.system_open, desc = "Open the file under cursor with system app" }
maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" }
maps.i["<C-BS>"] = { "<C-W>", desc = "Enable CTRL+backspace to delete." }
maps.n["0"] = { "^", desc = "Go to the fist character of the line (aliases 0 to ^)" }
maps.n["<leader>q"] = {
	function()
		require("core.utils").confirm_quit()
	end,
	desc = "Quit",
}
maps.n["<Tab>"] = {
	"<Tab>",
	noremap = true,
	silent = true,
	expr = false,
	desc = "FIX: Prevent TAB from behaving like <C-i>, as they share the same internal code",
}

-- clipboard ---------------------------------------------------------------
maps.n["<C-y>"] = { '"+y<esc>', desc = "Copy to cliboard" }
maps.x["<C-y>"] = { '"+y<esc>', desc = "Copy to cliboard" }
maps.n["<C-p>"] = { '"+p<esc>', desc = "Paste from clipboard" }

-- Make 'c' key not copy to clipboard when changing a character.
maps.n["c"] = { '"_c', desc = "Change without yanking" }
maps.n["C"] = { '"_C', desc = "Change without yanking" }
maps.x["c"] = { '"_c', desc = "Change without yanking" }
maps.x["C"] = { '"_C', desc = "Change without yanking" }

-- Make 'x' key not copy to clipboard when deleting a character.
maps.n["x"] = {
	-- Also let's allow 'x' key to delete blank lines in normal mode.
	function()
		if vim.fn.col(".") == 1 then
			local line = vim.fn.getline(".")
			if line:match("^%s*$") then
				vim.api.nvim_feedkeys('"_dd', "n", false)
				vim.api.nvim_feedkeys("$", "n", false)
			else
				vim.api.nvim_feedkeys('"_x', "n", false)
			end
		else
			vim.api.nvim_feedkeys('"_x', "n", false)
		end
	end,
	desc = "Delete character without yanking it",
}
maps.x["x"] = { '"_x', desc = "Delete all characters in line" }

-- Same for shifted X
maps.n["X"] = {
	-- Also let's allow 'x' key to delete blank lines in normal mode.
	function()
		if vim.fn.col(".") == 1 then
			local line = vim.fn.getline(".")
			if line:match("^%s*$") then
				vim.api.nvim_feedkeys('"_dd', "n", false)
				vim.api.nvim_feedkeys("$", "n", false)
			else
				vim.api.nvim_feedkeys('"_X', "n", false)
			end
		else
			vim.api.nvim_feedkeys('"_X', "n", false)
		end
	end,
	desc = "Delete before character without yanking it",
}
maps.x["X"] = { '"_X', desc = "Delete all characters in line" }

-- Override nvim default behavior so it doesn't auto-yank when pasting on visual mode.
maps.x["p"] = { "P", desc = "Paste content you've previourly yanked" }
maps.x["P"] = { "p", desc = "Yank what you are going to override, then paste" }

-- search highlighting ------------------------------------------------------
-- use ESC to clear hlsearch, while preserving its original functionality.
--
-- TIP: If you prefer,  use <leader>ENTER instead of <ESC>
--      to avoid triggering it by accident.
maps.n["<ESC>"] = {
	function()
		if vim.fn.hlexists("Search") then
			vim.cmd("nohlsearch")
		else
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
		end
	end,
}

-- Improved tabulation ------------------------------------------------------
maps.x["<S-Tab>"] = { "<gv", desc = "unindent line" }
maps.x["<Tab>"] = { ">gv", desc = "indent line" }
maps.x["<"] = { "<gv", desc = "unindent line" }
maps.x[">"] = { ">gv", desc = "indent line" }

-- improved gg --------------------------------------------------------------
maps.n["gg"] = {
	function()
		vim.g.minianimate_disable = true
		if vim.v.count > 0 then
			vim.cmd("normal! " .. vim.v.count .. "gg")
		else
			vim.cmd("normal! gg0")
		end
		vim.g.minianimate_disable = false
	end,
	desc = "gg and go to the first position",
}
maps.n["G"] = {
	function()
		vim.g.minianimate_disable = true
		vim.cmd("normal! G$")
		vim.g.minianimate_disable = false
	end,
	desc = "G and go to the last position",
}
maps.x["gg"] = {
	function()
		vim.g.minianimate_disable = true
		if vim.v.count > 0 then
			vim.cmd("normal! " .. vim.v.count .. "gg")
		else
			vim.cmd("normal! gg0")
		end
		vim.g.minianimate_disable = false
	end,
	desc = "gg and go to the first position (visual)",
}
maps.x["G"] = {
	function()
		vim.g.minianimate_disable = true
		vim.cmd("normal! G$")
		vim.g.minianimate_disable = false
	end,
	desc = "G and go to the last position (visual)",
}
maps.n["<C-a>"] = { -- to move to the previous position press ctrl + oo
	function()
		vim.g.minianimate_disable = true
		vim.cmd("normal! gg0vG$")
		vim.g.minianimate_disable = false
	end,
	desc = "Visually select all",
}

-- packages -----------------------------------------------------------------
-- lazy
maps.n["<leader>p"] = icons.p
maps.n["<leader>pu"] = {
	function()
		require("lazy").check()
	end,
	desc = "Lazy open",
}
maps.n["<leader>pU"] = {
	function()
		require("lazy").update()
	end,
	desc = "Lazy update",
}

-- mason
if is_available("mason.nvim") then
	maps.n["<leader>pm"] = { "<cmd>Mason<cr>", desc = "Mason open" }
	maps.n["<leader>pM"] = { "<cmd>MasonUpdateAll<cr>", desc = "Mason update" }
end

-- treesitter
if is_available("nvim-treesitter") then
	maps.n["<leader>pT"] = { "<cmd>TSUpdate<cr>", desc = "Treesitter update" }
	maps.n["<leader>pt"] = { "<cmd>TSInstallInfo<cr>", desc = "Treesitter open" }
end

-- buffers/tabs [buffers ]--------------------------------------------------

maps.n["<leader>b"] = icons.b
maps.n["<leader>ba"] = {
	function()
		vim.cmd("wa")
	end,
	desc = "Write all changed buffers",
}
if is_available("fzf-lua") then
	maps.n["<leader>bf"] = {
		function()
			require("fzf-lua").buffers()
		end,
		desc = "Find buffers",
	}
end

-- tabs
maps.n["]t"] = {
	function()
		vim.cmd.tabnext()
	end,
	desc = "Next tab",
}
maps.n["[t"] = {
	function()
		vim.cmd.tabprevious()
	end,
	desc = "Previous tab",
}

-- ui toggles [ui] ---------------------------------------------------------
maps.n["<leader>u"] = icons.u
if is_available("nvim-autopairs") then
	maps.n["<leader>ua"] = { ui.toggle_autopairs, desc = "Autopairs" }
end
maps.n["<leader>ub"] = { ui.toggle_background, desc = "Background" }
if is_available("nvim-cmp") then
	maps.n["<leader>uc"] = { ui.toggle_cmp, desc = "Autocompletion" }
end
if is_available("nvim-colorizer.lua") then
	maps.n["<leader>uC"] = { "<cmd>ColorizerToggle<cr>", desc = "color highlight" }
end
maps.n["<leader>ud"] = { ui.toggle_diagnostics, desc = "Diagnostics" }
maps.n["<leader>uD"] = { ui.set_indent, desc = "Change indent setting" }
maps.n["<leader>ug"] = { ui.toggle_signcolumn, desc = "Signcolumn" }
maps.n["<leader>ul"] = { ui.toggle_statusline, desc = "Statusline" }
maps.n["<leader>uL"] = { ui.toggle_codelens, desc = "CodeLens" }
maps.n["<leader>un"] = { ui.change_number, desc = "Change line numbering" }
maps.n["<leader>uP"] = { ui.toggle_paste, desc = "Paste mode" }
maps.n["<leader>us"] = { ui.toggle_spell, desc = "Spellcheck" }
maps.n["<leader>uS"] = { ui.toggle_conceal, desc = "Conceal" }
maps.n["<leader>ut"] = { ui.toggle_tabline, desc = "Tabline" }
maps.n["<leader>uu"] = { ui.toggle_url_effect, desc = "URL highlight" }
maps.n["<leader>uw"] = { ui.toggle_wrap, desc = "Wrap" }
maps.n["<leader>uy"] = { ui.toggle_buffer_syntax, desc = "Syntax highlight (buffer)" }
maps.n["<leader>uh"] = { ui.toggle_foldcolumn, desc = "Foldcolumn" }
maps.n["<leader>uN"] = { ui.toggle_ui_notifications, desc = "UI notifications" }
if is_available("lsp_signature.nvim") then
	maps.n["<leader>up"] = { ui.toggle_lsp_signature, desc = "LSP signature" }
end
if is_available("mini.animate") then
	maps.n["<leader>uA"] = { ui.toggle_animations, desc = "Animations" }
end

-- shifted movement keys ----------------------------------------------------
maps.n["<S-Down>"] = {
	function()
		vim.api.nvim_feedkeys("7j", "n", true)
	end,
	desc = "Fast move down",
}
maps.n["<S-Up>"] = {
	function()
		vim.api.nvim_feedkeys("7k", "n", true)
	end,
	desc = "Fast move up",
}
maps.n["<S-PageDown>"] = {
	function()
		local current_line = vim.fn.line(".")
		local total_lines = vim.fn.line("$")
		local target_line = current_line + 1 + math.floor(total_lines * 0.20)
		if target_line > total_lines then
			target_line = total_lines
		end
		vim.api.nvim_win_set_cursor(0, { target_line, 0 })
		vim.cmd("normal! zz")
	end,
	desc = "Page down exactly a 20% of the total size of the buffer",
}
maps.n["<S-PageUp>"] = {
	function()
		local current_line = vim.fn.line(".")
		local target_line = current_line - 1 - math.floor(vim.fn.line("$") * 0.20)
		if target_line < 1 then
			target_line = 1
		end
		vim.api.nvim_win_set_cursor(0, { target_line, 0 })
		vim.cmd("normal! zz")
	end,
	desc = "Page up exactly 20% of the total size of the buffer",
}

-- cmdline autocompletion ---------------------------------------------------
maps.c["<Up>"] = {
	function()
		return vim.fn.wildmenumode() == 1 and "<Left>" or "<Up>"
	end,
	noremap = true,
	expr = true,
	desc = "Wildmenu fix for neovim bug #9953",
}
maps.c["<Down>"] = {
	function()
		return vim.fn.wildmenumode() == 1 and "<Right>" or "<Down>"
	end,
	noremap = true,
	expr = true,
	desc = "Wildmenu fix for neovim bug #9953",
}
maps.c["<Left>"] = {
	function()
		return vim.fn.wildmenumode() == 1 and "<Up>" or "<Left>"
	end,
	noremap = true,
	expr = true,
	desc = "Wildmenu fix for neovim bug #9953",
}
maps.c["<Right>"] = {
	function()
		return vim.fn.wildmenumode() == 1 and "<Down>" or "<Right>"
	end,
	noremap = true,
	expr = true,
	desc = "Wildmenu fix for neovim bug #9953",
}

-- special cases ------------------------------------------------------------
vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Make q close help, man, quickfix, dap floats",
	callback = function(args)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
		if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) then
			vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true, nowait = true })
		end
	end,
})
vim.api.nvim_create_autocmd("CmdwinEnter", {
	desc = "Make q close command history (q: and q?)",
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true, nowait = true })
	end,
})

-- -------------------------------------------------------------------------
--
-- ## Plugin bindings
--
-- -------------------------------------------------------------------------

-- [git] -----------------------------------------------------------
-- gitsigns.nvim
maps.n["<leader>g"] = icons.g
if is_available("neogit") then
	maps.n["<leader>gg"] = {
		function()
			require("neogit").open()
		end,
		desc = "Neogit",
	}
end
if is_available("telescope.nvim") then
	maps.n["<leader>gb"] = {
		function()
			require("telescope.builtin").git_branches()
		end,
		desc = "Git branches",
	}
	maps.n["<leader>gc"] = {
		function()
			require("telescope.builtin").git_commits()
		end,
		desc = "Git commits (repository)",
	}
	maps.n["<leader>gC"] = {
		function()
			require("telescope.builtin").git_bcommits()
		end,
		desc = "Git commits (current file)",
	}
	maps.n["<leader>gt"] = {
		function()
			require("telescope.builtin").git_status()
		end,
		desc = "Git status",
	}
end
if is_available("gitsigns.nvim") then
	local gs = require("gitsigns")
	maps.n["]g"] = {
		function()
			gs.next_hunk()
		end,
		desc = "Next Git hunk",
	}
	maps.n["[g"] = {
		function()
			gs.prev_hunk()
		end,
		desc = "Previous Git hunk",
	}
	maps.n["<leader>gl"] = {
		function()
			gs.blame_line()
		end,
		desc = "View Git blame",
	}
	maps.n["<leader>gL"] = {
		function()
			gs.blame_line({ full = true })
		end,
		desc = "View full Git blame",
	}
	maps.n["<leader>gp"] = {
		function()
			gs.preview_hunk()
		end,
		desc = "Preview Git hunk",
	}
	maps.n["<leader>gh"] = {
		function()
			gs.reset_hunk()
		end,
		desc = "Reset Git hunk",
	}
	maps.n["<leader>gr"] = {
		function()
			gs.reset_buffer()
		end,
		desc = "Reset Git buffer",
	}
	maps.n["<leader>gs"] = {
		function()
			gs.stage_hunk()
		end,
		desc = "Stage Git hunk",
	}
	maps.n["<leader>gS"] = {
		function()
			gs.stage_buffer()
		end,
		desc = "Stage Git buffer",
	}
	maps.n["<leader>gu"] = {
		function()
			gs.undo_stage_hunk()
		end,
		desc = "Unstage Git hunk",
	}
end
-- diff view
if is_available("diffview.nvim") then
	maps.n["<leader>gd"] = icons.gd
	maps.n["<leader>gdo"] = {
		function()
			vim.cmd("DiffviewOpen")
		end,
		desc = "Open diff view",
	}
	maps.n["<leader>gdc"] = {
		function()
			vim.cmd("DiffviewClose")
		end,
		desc = "Close diff view",
	}
	maps.n["<leader>gdf"] = {
		function()
			vim.cmd("DiffviewFileHistory")
		end,
		desc = "File history (All commits)",
	}
	maps.n["<leader>gdd"] = {
		function()
			vim.cmd("DiffviewFileHistory %")
		end,
		desc = "File history (Current file)",
	}
end

-- file browsers ------------------------------------
-- neotree
if is_available("neo-tree.nvim") then
	maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Neotree" }
	maps.n["<leader>o"] = {
		function()
			if vim.bo.filetype == "neo-tree" then
				vim.cmd.wincmd("p")
			else
				vim.cmd.Neotree("focus")
			end
		end,
		desc = "Neotree Focus",
	}
end

-- smart-splits.nivm
if is_available("smart-splits.nvim") then
	maps.n["<C-h>"] = {
		function()
			require("smart-splits").move_cursor_left()
		end,
		desc = "Move to left split",
	}
	maps.n["<C-j>"] = {
		function()
			require("smart-splits").move_cursor_down()
		end,
		desc = "Move to below split",
	}
	maps.n["<C-k>"] = {
		function()
			require("smart-splits").move_cursor_up()
		end,
		desc = "Move to above split",
	}
	maps.n["<C-l>"] = {
		function()
			require("smart-splits").move_cursor_right()
		end,
		desc = "Move to right split",
	}
	maps.n["<C-Up>"] = {
		function()
			require("smart-splits").resize_up()
		end,
		desc = "Resize split up",
	}
	maps.n["<C-Down>"] = {
		function()
			require("smart-splits").resize_down()
		end,
		desc = "Resize split down",
	}
	maps.n["<C-Left>"] = {
		function()
			require("smart-splits").resize_left()
		end,
		desc = "Resize split left",
	}
	maps.n["<C-Right>"] = {
		function()
			require("smart-splits").resize_right()
		end,
		desc = "Resize split right",
	}
else
	maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
	maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
	maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
	maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
	maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
	maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
	maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
	maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

-- fzf-lua [find] -----------------------------------------------------------
if is_available("fzf-lua") then
	maps.n["<leader>f"] = {
		function()
			require("fzf-lua").files()
		end,
		desc = "Find file",
	}
end
-- telescope.nvim [find] ----------------------------------------------------
if is_available("telescope.nvim") then
	maps.n["<leader>s"] = icons.s
	maps.n["<leader>s<CR>"] = {
		function()
			require("telescope.builtin").resume()
		end,
		desc = "Resume previous search",
	}
	maps.n["<leader>s'"] = {
		function()
			require("telescope.builtin").marks()
		end,
		desc = "Marks",
	}
	maps.n["<leader>sa"] = {
		function()
			local cwd = vim.fn.stdpath("config") .. "/.."
			local search_dirs = { vim.fn.stdpath("config") }
			if #search_dirs == 1 then
				cwd = search_dirs[1]
			end -- if only one directory, focus cwd
			require("telescope.builtin").find_files({
				prompt_title = "Config Files",
				search_dirs = search_dirs,
				cwd = cwd,
				follow = true,
			}) -- call telescope
		end,
		desc = "Nvim config files",
	}
	maps.n["<leader>sw"] = {
		function()
			require("telescope.builtin").grep_string()
		end,
		desc = "Word under cursor in project",
	}
	maps.n["<leader>sC"] = {
		function()
			require("telescope.builtin").commands()
		end,
		desc = "Commands",
	}
	maps.n["<leader>sh"] = {
		function()
			require("telescope.builtin").help_tags()
		end,
		desc = "Help",
	}
	maps.n["<leader>sk"] = {
		function()
			require("telescope.builtin").keymaps()
		end,
		desc = "Keymaps",
	}
	maps.n["<leader>sm"] = {
		function()
			require("telescope.builtin").man_pages()
		end,
		desc = "Man pages",
	}
	if is_available("nvim-notify") then
		maps.n["<leader>sn"] = {
			function()
				require("telescope").extensions.notify.notify()
			end,
			desc = "Notifications",
		}
	end
	maps.n["<leader>so"] = {
		function()
			require("telescope.builtin").oldfiles()
		end,
		desc = "Recent",
	}
	maps.n["<leader>sv"] = {
		function()
			require("telescope.builtin").registers()
		end,
		desc = "Vim registers",
	}
	maps.n["<leader>st"] = {
		function()
			-- load color schemes before listing them
			pcall(vim.api.nvim_command, "doautocmd User LoadColorSchemes")

			-- Open telescope
			pcall(require("telescope.builtin").colorscheme, { enable_preview = true })
		end,
		desc = "Themes",
	}
	maps.n["<leader>sF"] = {
		function()
			require("telescope.builtin").live_grep({
				additional_args = function(args)
					return vim.list_extend(args, { "--hidden", "--no-ignore" })
				end,
			})
		end,
		desc = "Words in project",
	}
	maps.n["<leader>sf"] = {
		function()
			require("telescope.builtin").live_grep()
		end,
		desc = "Words in project (no hidden)",
	}
	maps.n["<leader>s/"] = {
		function()
			require("telescope.builtin").current_buffer_fuzzy_find()
		end,
		desc = "Words in current buffer",
	}

	-- extra - project.nvim
	if is_available("project.nvim") then
		maps.n["<leader>sp"] = {
			function()
				vim.cmd("Telescope projects")
			end,
			desc = "Project",
		}
	end

	-- extra - spectre.nvim (search and replace in project)
	if is_available("nvim-spectre") then
		maps.n["<leader>sr"] = {
			function()
				require("spectre").toggle()
			end,
			desc = "Find and replace word in project",
		}
		maps.n["<leader>sb"] = {
			function()
				require("spectre").toggle({ path = vim.fn.expand("%:t:p") })
			end,
			desc = "Find and replace word in buffer",
		}
	end

	-- extra - luasnip
	if is_available("LuaSnip") and is_available("telescope-luasnip.nvim") then
		maps.n["<leader>ss"] = {
			function()
				require("telescope").extensions.luasnip.luasnip({})
			end,
			desc = "Snippets",
		}
	end

	-- extra - nvim-neoclip (neovim internal clipboard)
	--         Specially useful if you disable the shared clipboard in options.
	if is_available("nvim-neoclip.lua") then
		maps.n["<leader>sy"] = {
			function()
				require("telescope").extensions.neoclip.default()
			end,
			desc = "Yank history",
		}
		maps.n["<leader>sq"] = {
			function()
				require("telescope").extensions.macroscope.default()
			end,
			desc = "macro history",
		}
	end

	-- extra - undotree
	if is_available("telescope-undo.nvim") then
		maps.n["<leader>su"] = {
			function()
				require("telescope").extensions.undo.undo()
			end,
			desc = "Find in undo tree",
		}
	end

	-- extra - compiler
	if is_available("compiler.nvim") and is_available("overseer.nvim") then
		maps.n["<leader>m"] = icons.c
		maps.n["<leader>mm"] = {
			function()
				vim.cmd("CompilerOpen")
			end,
			desc = "Open compiler",
		}
		maps.n["<leader>mr"] = {
			function()
				vim.cmd("CompilerRedo")
			end,
			desc = "Compiler redo",
		}
		maps.n["<leader>mt"] = {
			function()
				vim.cmd("CompilerToggleResults")
			end,
			desc = "compiler results",
		}
		maps.n["<F6>"] = {
			function()
				vim.cmd("CompilerOpen")
			end,
			desc = "Open compiler",
		}
		maps.n["<S-F6>"] = {
			function()
				vim.cmd("CompilerRedo")
			end,
			desc = "Compiler redo",
		}
		maps.n["<S-F7>"] = {
			function()
				vim.cmd("CompilerToggleResults")
			end,
			desc = "compiler resume",
		}
	end
end

-- toggleterm.nvim ----------------------------------------------------------
if is_available("toggleterm.nvim") then
	maps.n["<leader>T"] = icons.t
	maps.n["<leader>Tt"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" }
	maps.n["<leader>Th"] = {
		"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
		desc = "Toggleterm horizontal split",
	}
	maps.n["<leader>Tv"] = {
		"<cmd>ToggleTerm size=80 direction=vertical<cr>",
		desc = "Toggleterm vertical split",
	}
	maps.n["<F7>"] = { "<cmd>ToggleTerm<cr>", desc = "terminal" }
	maps.t["<F7>"] = maps.n["<F7>"]
	maps.n["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>
	maps.t["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>

	-- git client
	if vim.fn.executable("lazygit") == 1 then -- if lazygit exists, show it
		maps.n["<leader>Tl"] = {
			function()
				local git_dir = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
				if git_dir ~= "" then
					utils.toggle_term_cmd("lazygit")
				else
					utils.notify("Not a git repository", 4)
				end
			end,
			desc = "ToggleTerm lazygit",
		}
	end
end

-- extra - improved terminal navigation
maps.t["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" }
maps.t["<C-j>"] = { "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" }
maps.t["<C-k>"] = { "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" }
maps.t["<C-l>"] = { "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" }

-- dap.nvim [debugger] -----------------------------------------------------
-- Depending your terminal some F keys may not work. To fix it:
-- modified function keys found with `showkey -a` in the terminal to get key code
-- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
if is_available("nvim-dap") then
	maps.n["<leader>d"] = icons.d
	maps.x["<leader>d"] = icons.d

	-- F keys
	maps.n["<F5>"] = {
		function()
			require("dap").continue()
		end,
		desc = "Debugger: Start",
	}
	maps.n["<S-F5>"] = {
		function()
			require("dap").terminate()
		end,
		desc = "Debugger: Stop",
	}
	maps.n["<C-F5>"] = {
		function()
			require("dap").restart_frame()
		end,
		desc = "Debugger: Restart",
	}
	maps.n["<F9>"] = {
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "Debugger: Toggle Breakpoint",
	}
	maps.n["<S-F9>"] = {
		function()
			vim.ui.input({ prompt = "Condition: " }, function(condition)
				if condition then
					require("dap").set_breakpoint(condition)
				end
			end)
		end,
		desc = "Debugger: Conditional Breakpoint",
	}
	maps.n["<F10>"] = {
		function()
			require("dap").step_over()
		end,
		desc = "Debugger: Step Over",
	}
	maps.n["<S-F10>"] = {
		function()
			require("dap").step_back()
		end,
		desc = "Debugger: Step Back",
	}
	maps.n["<F11>"] = {
		function()
			require("dap").step_into()
		end,
		desc = "Debugger: Step Into",
	}
	maps.n["<S-11>"] = {
		function()
			require("dap").step_out()
		end,
		desc = "Debugger: Step Out",
	}

	-- Space + d
	maps.n["<leader>db"] = {
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "Breakpoint (F9)",
	}
	maps.n["<leader>dB"] = {
		function()
			require("dap").clear_breakpoints()
		end,
		desc = "Clear Breakpoints",
	}
	maps.n["<leader>dc"] = {
		function()
			require("dap").continue()
		end,
		desc = "Start/Continue (F5)",
	}
	maps.n["<leader>dC"] = {
		function()
			vim.ui.input({ prompt = "Condition: " }, function(condition)
				if condition then
					require("dap").set_breakpoint(condition)
				end
			end)
		end,
		desc = "Conditional Breakpoint (S-F9)",
	}
	maps.n["<leader>do"] = {
		function()
			require("dap").step_over()
		end,
		desc = "Step Over (F10)",
	}
	maps.n["<leader>du"] = {
		function()
			require("dap").step_back()
		end,
		desc = "Step Back (S-F10)",
	}
	maps.n["<leader>di"] = {
		function()
			require("dap").step_into()
		end,
		desc = "Step Into (F11)",
	}
	maps.n["<leader>dO"] = {
		function()
			require("dap").step_out()
		end,
		desc = "Step Out (S-F11)",
	}
	maps.n["<leader>dq"] = {
		function()
			require("dap").close()
		end,
		desc = "Close Session",
	}
	maps.n["<leader>dQ"] = {
		function()
			require("dap").terminate()
		end,
		desc = "Terminate Session (S-F5)",
	}
	maps.n["<leader>dp"] = {
		function()
			require("dap").pause()
		end,
		desc = "Pause",
	}
	maps.n["<leader>dr"] = {
		function()
			require("dap").restart_frame()
		end,
		desc = "Restart (C-F5)",
	}
	maps.n["<leader>dR"] = {
		function()
			require("dap").repl.toggle()
		end,
		desc = "REPL",
	}
	maps.n["<leader>ds"] = {
		function()
			require("dap").run_to_cursor()
		end,
		desc = "Run To Cursor",
	}

	if is_available("nvim-dap-ui") then
		maps.n["<leader>dE"] = {
			function()
				vim.ui.input({ prompt = "Expression: " }, function(expr)
					if expr then
						require("dapui").eval(expr, { enter = true })
					end
				end)
			end,
			desc = "Evaluate Input",
		}
		maps.x["<leader>dE"] = {
			function()
				require("dapui").eval()
			end,
			desc = "Evaluate Input",
		}
		maps.n["<leader>du"] = {
			function()
				require("dapui").toggle()
			end,
			desc = "Debugger UI",
		}
		maps.n["<leader>dh"] = {
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Debugger Hover",
		}
	end
end

-- testing [tests] -------------------------------------------------
-- neotest
maps.n["<leader>t"] = icons.tt
maps.x["<leader>t"] = icons.tt
if is_available("neotest") then
	maps.n["<leader>tu"] = {
		function()
			require("neotest").run.run()
		end,
		desc = "Unit",
	}
	maps.n["<leader>ts"] = {
		function()
			require("neotest").run.stop()
		end,
		desc = "Stop unit",
	}
	maps.n["<leader>tf"] = {
		function()
			require("neotest").run.run(vim.fn.expand("%"))
		end,
		desc = "File",
	}
	maps.n["<leader>td"] = {
		function()
			require("neotest").run.run({ strategy = "dap" })
		end,
		desc = "Unit in debugger",
	}
	maps.n["<leader>tt"] = {
		function()
			require("neotest").summary.toggle()
		end,
		desc = "Neotest summary",
	}
	maps.n["<leader>tp"] = {
		function()
			require("neotest").output_panel.toggle()
		end,
		desc = "Output panel",
	}
end

-- Extra - nvim-coverage
--         Your project must generate coverage/lcov.info for this to work.
--
--         On jest, make sure your packages.json file has this:
--         "test": "jest --coverage"
--
--         If you use other framework or language, refer to nvim-coverage docs:
--         https://github.com/andythigpen/nvim-coverage/blob/main/doc/nvim-coverage.txt
if is_available("nvim-coverage") then
	maps.n["<leader>tc"] = {
		function()
			utils.notify("Attempting to find coverage/lcov.info in project root...", 3)
			require("coverage").load(false)
			require("coverage").summary()
		end,
		desc = "Coverage",
	}
end

-- Extra - nodejs testing commands
maps.n["<leader>ta"] = {
	function()
		vim.cmd("TestNodejs")
	end,
	desc = "All (Node)",
}
maps.n["<leader>te"] = {
	function()
		vim.cmd("TestNodejsE2e")
	end,
	desc = "E2e (Node)",
}

-- nvim-ufo [code folding] --------------------------------------------------
if is_available("nvim-ufo") then
	maps.n["zR"] = {
		function()
			require("ufo").openAllFolds()
		end,
		desc = "Open all folds",
	}
	maps.n["zM"] = {
		function()
			require("ufo").closeAllFolds()
		end,
		desc = "Close all folds",
	}
	maps.n["zr"] = {
		function()
			require("ufo").openFoldsExceptKinds()
		end,
		desc = "Fold less",
	}
	maps.n["zm"] = {
		function()
			require("ufo").closeFoldsWith()
		end,
		desc = "Fold more",
	}
	maps.n["zp"] = {
		function()
			require("ufo").peekFoldedLinesUnderCursor()
		end,
		desc = "Peek fold",
	}
	maps.n["zn"] = {
		function()
			require("ufo").openFoldsExceptKinds({ "comment" })
		end,
		desc = "Fold comments",
	}
	maps.n["zN"] = {
		function()
			require("ufo").openFoldsExceptKinds({ "region" })
		end,
		desc = "Fold region",
	}
end

-- code docmentation [docs] -------------------------------------------------

if is_available("markdown-preview.nivm") or is_available("markmap.nvim") or is_available("dooku.nvim") then
	maps.n["<leader>D"] = icons.dc

	-- Markdown preview
	if is_available("markdown-preview.nvim") then
		maps.n["<leader>Dp"] = {
			function()
				vim.cmd("MarkdownPreview")
			end,
			desc = "Markdown preview",
		}
	end

	-- Markdown Mindmap
	if is_available("markmap.nvim") then
		maps.n["<leader>Dm"] = {
			function()
				vim.cmd("MarkmapOpen")
			end,
			desc = "Markmap",
		}
	end

	if is_available("dooku.nvim") then
		maps.n["<leader>Dd"] = {
			function()
				vim.cmd(":DookuGenerate")
			end,
			desc = "Open documentation",
		}
	end
end

-- [neural] -----------------------------------------------------------------
if is_available("neural") or is_available("copilot") then
	maps.n["<leader>a"] = {
		function()
			require("neural").prompt()
		end,
		desc = "Ask chatgpt",
	}
end

-- hop.nivm ----------------------------------------------------------------
if is_available("hop.nvim") then
	-- Note that Even though we are using ENTER for hop, you can still select items
	-- from special menus like 'quickfix', 'q?' and 'q:' with <C+ENTER>.

	maps.n["<C-m>"] = { -- The terminal undersand C-m and ENTER as the same key.
		function()
			require("hop")
			vim.cmd("silent! HopWord")
		end,
		desc = "Hop to word",
	}
	maps.x["<C-m>"] = { -- The terminal undersand C-m and ENTER as the same key.
		function()
			require("hop")
			vim.cmd("silent! HopWord")
		end,
		desc = "Hop to word",
	}
end

-- A function we call from the script to start lsp.
---@return table lsp_mappings #
function M.lsp_mappings(client, bufnr)
	--- Helper function to check if any active LSP clients
	--- given a filter provide a specific capability.
	---@param capability string The server capability to check for (example: "documentFormattingProvider").
	---@param filter vim.lsp.get_active_clients.filter|nil A valid get_active_clients filter (see function docs).
	---@return boolean # `true` if any of the clients provide the capability.
	local function has_capability(capability, filter)
		for _, lsp_client in ipairs(vim.lsp.get_active_clients(filter)) do
			if lsp_client.supports_method(capability) then
				return true
			end
		end
		return false
	end

	local isJava = client.name == "jdtls"

	local lsp_mappings = require("core.utils").get_mappings_template()
	maps.n["<leader>l"] = icons.l
	lsp_mappings.n["[d"] = {
		function()
			vim.diagnostic.goto_prev()
		end,
		desc = "Previous diagnostic",
	}
	lsp_mappings.n["]d"] = {
		function()
			vim.diagnostic.goto_next()
		end,
		desc = "Next diagnostic",
	}
	lsp_mappings.n["gl"] = {
		function()
			vim.diagnostic.open_float()
		end,
		desc = "Hover diagnostics",
	}

	if is_available("telescope.nvim") then
		lsp_mappings.n["<leader>ld"] = {
			function()
				vim.cmd("Telescope diagnostics bufnr=0 theme=get_ivy")
			end,
			desc = "Buffer diagnostics",
		}
		lsp_mappings.n["<leader>lw"] = {
			function()
				require("telescope.builtin").diagnostics(require("telescope.themes").get_ivy())
			end,
			desc = "Workspace diagnostics",
		}
		lsp_mappings.n["<leader>ls"] = {
			function()
				local aerial_avail, _ = pcall(require, "aerial")
				if aerial_avail then
					vim.cmd("Telescope aerial aerial theme=get_ivy")
				else
					require("telescope.builtin").lsp_document_symbols(require("telescope.theme").get_ivy())
				end
			end,
			desc = "Search symbol in buffer", -- Useful to find every time a variable is assigned.
		}
		lsp_mappings.n["gs"] = {
			function()
				local aerial_avail, _ = pcall(require, "aerial")
				if aerial_avail then
					vim.cmd("Telescope aerial aerial theme=get_ivy")
				else
					require("telescope.builtin").lsp_document_symbols(require("telescope.theme").get_ivy())
				end
			end,
			desc = "Search symbol in buffer", -- Useful to find every time a variable is assigned.
		}
	end

	if is_available("aerial") then
		lsp_mappings.n["<leader>lo"] = {
			function()
				require("aerial").toggle()
			end,
			desc = "Aerial symbols",
		}
	end

	if is_available("mason-lspconfig.nvim") then
		lsp_mappings.n["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" }
	end

	if is_available("none-ls.nvim") then
		lsp_mappings.n["<leader>lI"] = { "<cmd>NullLsInfo<cr>", desc = "Null-ls information" }
	end

	if isJava or client.supports_method("textDocument/codeAction") then
		lsp_mappings.n["<leader>la"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			desc = "LSP code action",
		}
		lsp_mappings.v["<leader>la"] = lsp_mappings.n["<leader>la"]
	end

	if isJava or client.supports_method("textDocument/codeLens") then
		utils.add_autocmds("lsp_codelens_refresh", bufnr, {
			events = { "InsertLeave", "BufEnter" },
			desc = "Refresh codelens",
			callback = function(args)
				if not has_capability("textDocument/codeLens", { bufnr = bufnr }) then
					utils.del_autocmds("lsp_codelens_refresh", bufnr)
					return
				end
				if vim.g.codelens_enabled then
					vim.lsp.codelens.refresh({ bufnr = args.buf })
				end
			end,
		})
		if vim.g.codelens_enabled then
			vim.lsp.codelens.refresh()
		end
		lsp_mappings.n["<leader>ll"] = {
			function()
				vim.lsp.codelens.run()
			end,
			desc = "LSP CodeLens run",
		}
	end

	lsp_mappings.n["<leader>lL"] = {
		function()
			vim.api.nvim_command(":LspRestart")
		end,
		desc = "LSP refresh",
	}

	if isJava or client.supports_method("textDocument/declaration") then
		lsp_mappings.n["gD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
			desc = "Declaration of current symbol",
		}
	end

	if isJava or client.supports_method("textDocument/definition") then
		lsp_mappings.n["gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			desc = "Show the definition of current symbol",
		}
	end

	local formatting = require("core.utils.lsp").formatting
	if
		isJava
		or client.supports_method("textDocument/formatting")
			and not vim.tbl_contains(formatting.disabled, client.name)
	then
		lsp_mappings.n["<leader>lf"] = {
			function()
				vim.lsp.buf.format(M.format_opts)
			end,
			desc = "Format buffer",
		}
		lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]

		vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
			vim.lsp.buf.format(M.format_opts)
		end, { desc = "Format file with LSP" })
		local autoformat = formatting.format_on_save
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
		if
			autoformat.enabled
			and (vim.tbl_isempty(autoformat.allow_filetypes or {}) or vim.tbl_contains(
				autoformat.allow_filetypes,
				filetype
			))
			and (
				vim.tbl_isempty(autoformat.ignore_filetypes or {})
				or not vim.tbl_contains(autoformat.ignore_filetypes, filetype)
			)
		then
			utils.add_autocmds("lsp_auto_format", bufnr, {
				events = "BufWritePre",
				desc = "Autoformat on save",
				callback = function()
					if not has_capability("textDocument/formatting", { bufnr = bufnr }) then
						utils.del_autocmds("lsp_auto_format", bufnr)
						return
					end
					local autoformat_enabled = vim.b.autoformat_enabled
					if autoformat_enabled == nil then
						autoformat_enabled = vim.g.autoformat_enabled
					end
					if autoformat_enabled and ((not autoformat.filter) or autoformat.filter(bufnr)) then
						vim.lsp.buf.format(utils.extend_tbl(M.format_opts, { bufnr = bufnr }))
					end
				end,
			})
			lsp_mappings.n["<leader>uf"] = {
				function()
					require("core.utils.ui").toggle_buffer_autoformat()
				end,
				desc = "Autoformatting (buffer)",
			}
			lsp_mappings.n["<leader>uF"] = {
				function()
					require("core.utils.ui").toggle_autoformat()
				end,
				desc = "Autoformatting (global)",
			}
		end
	end

	if isJava or client.supports_method("textDocument/documentHighlight") then
		utils.add_autocmds("lsp_document_highlight", bufnr, {
			{
				events = { "CursorHold", "CursorHoldI" },
				desc = "highlight references when cursor holds",
				callback = function()
					if not has_capability("textDocument/documentHighlight", { bufnr = bufnr }) then
						utils.del_autocmds("lsp_document_highlight", bufnr)
						return
					end
					vim.lsp.buf.document_highlight()
				end,
			},
			{
				events = { "CursorMoved", "CursorMovedI", "BufLeave" },
				desc = "clear references when cursor moves",
				callback = function()
					vim.lsp.buf.clear_references()
				end,
			},
		})
	end

	if isJava or client.supports_method("textDocument/hover") then
		lsp_mappings.n["<leader>lh"] = {
			function()
				vim.lsp.buf.hover()
			end,
			desc = "Hover help",
		}
		lsp_mappings.n["gh"] = {
			function()
				vim.lsp.buf.hover()
			end,
			desc = "Hover help",
		}
	end

	-- Specialized version of hover for functions.
	-- Hides the returned object, but it highlights the parameters.
	if isJava or client.supports_method("textDocument/signatureHelp") then
		lsp_mappings.n["<leader>lH"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			desc = "Signature help",
		}
		lsp_mappings.n["gH"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			desc = "Signature help",
		}
	end

	if isJava or client.supports_method("textDocument/hover") then
		lsp_mappings.n["<leader>lm"] = {
			function()
				vim.api.nvim_feedkeys("K", "n", false)
			end,
			desc = "Hover man",
		}
		lsp_mappings.n["gm"] = {
			function()
				vim.api.nvim_feedkeys("K", "n", false)
			end,
			desc = "Hover man",
		}
	end

	if isJava or client.supports_method("textDocument/implementation") then
		lsp_mappings.n["gI"] = {
			function()
				vim.lsp.buf.implementation()
			end,
			desc = "Implementation of current symbol",
		}
	end

	if isJava or client.supports_method("textDocument/inlayHint") then
		if vim.b.inlay_hints_enabled == nil then
			vim.b.inlay_hints_enabled = vim.g.inlay_hints_enabled
		end
		-- TODO: remove check after dropping support for Neovim v0.9
		if vim.lsp.inlay_hint then
			if vim.b.inlay_hints_enabled then
				vim.lsp.inlay_hint(bufnr, true)
			end
			lsp_mappings.n["<leader>uH"] = {
				function()
					require("core.utils.ui").toggle_buffer_inlay_hints(bufnr)
				end,
				desc = "LSP inlay hints (buffer)",
			}
		end
	end

	if isJava or client.supports_method("textDocument/references") then
		lsp_mappings.n["<leader>lR"] = {
			function()
				vim.lsp.buf.references()
			end,
			desc = "Hover references",
		}
		lsp_mappings.n["gr"] = {
			function()
				vim.lsp.buf.references()
			end,
			desc = "References of current symbol",
		}
	end

	if isJava or client.supports_method("textDocument/rename") then
		lsp_mappings.n["<leader>lr"] = {
			function()
				vim.lsp.buf.rename()
			end,
			desc = "Rename current symbol",
		}
	end

	if isJava or client.supports_method("textDocument/typeDefinition") then
		lsp_mappings.n["gT"] = {
			function()
				vim.lsp.buf.type_definition()
			end,
			desc = "Definition of current type",
		}
	end

	if isJava or client.supports_method("workspace/symbol") then
		lsp_mappings.n["<leader>lS"] = {
			function()
				vim.lsp.buf.workspace_symbol()
			end,
			desc = "Search symbol in workspace",
		}
		lsp_mappings.n["gS"] = {
			function()
				vim.lsp.buf.workspace_symbol()
			end,
			desc = "Search symbol in workspace",
		}
	end

	if isJava or client.supports_method("textDocument/semanticTokens/full") and vim.lsp.semantic_tokens then
		if vim.g.semantic_tokens_enabled then
			vim.b[bufnr].semantic_tokens_enabled = true
			lsp_mappings.n["<leader>uY"] = {
				function()
					require("core.utils.ui").toggle_buffer_semantic_tokens(bufnr)
				end,
				desc = "LSP semantic highlight (buffer)",
			}
		else
			client.server_capabilities.semanticTokensProvider = nil
		end
	end

	if is_available("telescope.nvim") then -- setup telescope mappings if available
		if lsp_mappings.n.gd then
			lsp_mappings.n.gd[1] = function()
				require("telescope.builtin").lsp_definitions()
			end
		end
		if lsp_mappings.n.gI then
			lsp_mappings.n.gI[1] = function()
				require("telescope.builtin").lsp_implementations()
			end
		end
		if lsp_mappings.n.gr then
			lsp_mappings.n.gr[1] = function()
				require("telescope.builtin").lsp_references()
			end
		end
		if lsp_mappings.n["<leader>lR"] then
			lsp_mappings.n["<leader>lR"][1] = function()
				require("telescope.builtin").lsp_references()
			end
		end
		if lsp_mappings.n.gy then
			lsp_mappings.n.gy[1] = function()
				require("telescope.builtin").lsp_type_definitions()
			end
		end
		if lsp_mappings.n["<leader>lS"] then
			lsp_mappings.n["<leader>lS"][1] = function()
				vim.ui.input({ prompt = "Symbol Query: (leave empty for word under cursor)" }, function(query)
					if query then
						-- word under cursor if given query is empty
						if query == "" then
							query = vim.fn.expand("<cword>")
						end
						require("telescope.builtin").lsp_workspace_symbols({
							query = query,
							prompt_title = ("Find word (%s)"):format(query),
						})
					end
				end)
			end
		end
		if lsp_mappings.n["gS"] then
			lsp_mappings.n["gS"][1] = function()
				vim.ui.input({ prompt = "Symbol Query: (leave empty for word under cursor)" }, function(query)
					if query then
						-- word under cursor if given query is empty
						if query == "" then
							query = vim.fn.expand("<cword>")
						end
						require("telescope.builtin").lsp_workspace_symbols({
							query = query,
							prompt_title = ("Find word (%s)"):format(query),
						})
					end
				end)
			end
		end
	end

	return lsp_mappings
end

utils.set_mappings(maps)
return M
