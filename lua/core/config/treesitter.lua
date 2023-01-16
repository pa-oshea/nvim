local status_ok, _ = pcall(require, "nvim-treesitter")
if not status_ok then
	vim.notify("Treesitter now loaded", "error")
	return
end

local status_ok_ts, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok_ts then
	vim.notify("Treesitter configs could not be loaded", "error")
	return
end

local lines = vim.fn.line("$")
if lines > 30000 then
	vim.cmd([[syntax manual]])
	print("skip treesitter")
	return
end

local enable = false
local langtree = false

if lines > 7000 then
	enable = false
	langtree = false
	vim.cmd([[syntax on]])
else
	enable = true
	langtree = true
	print("ts enabled")
end

local ts_ensure_installed = {
	"bash",
	"go",
	"css",
	"html",
	"javascript",
	"typescript",
	"jsdoc",
	"json",
	"c",
	"java",
	"toml",
	"tsx",
	"lua",
	"cpp",
	"python",
	"rust",
	"jsonc",
	"yaml",
	"sql",
	"vue",
	"vim",
}

configs.setup({
	ensure_installed = ts_ensure_installed,
	highlight = {
		enable = enable,
		use_languagetree = langtree,
	},
	indent = { enable = enable },
	autopair = { enable = enable },
	rainbow = { enable = enable, extended_mode = true },
	incremental_selection = {
		enable = enable,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decrementel = "<c-backspace>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },
				["ia"] = { query = "@parameter.inner", desc = "Select inner parameter" },
				["af"] = { query = "@function.outer", desc = "Select outer function" },
				["if"] = { query = "@function.inner", desc = "Select inner function" },
				["ac"] = { query = "@class.outer", desc = "Select outer class" },
				["ic"] = { query = "@class.inner", desc = "Select inner class" },
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})
