local utils = require("core.utils")
return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"hiphish/rainbow-delimiters.nvim",
		},
		event = "User BaseFile",
		cmd = {
			"TSBufDisable",
			"TSBufEnable",
			"TSBufToggle",
			"TSDisable",
			"TSEnable",
			"TSToggle",
			"TSInstall",
			"TSInstallInfo",
			"TSInstallSync",
			"TSModuleInfo",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"css",
				"git_config",
				"go",
				"html",
				"javascript",
				"json",
				"jsdoc",
				"lua",
				"sql",
				"typescript",
				"xml",
				"yaml",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
			auto_install = true,
			autotag = { enable = true },
			rainbow = {
				enable = true,
			},
			highlight = {
				enable = true,
				disable = function(_, bufnr)
					return utils.is_big_file(bufnr)
				end,
			},
			matchup = {
				enable = true,
				enable_quotes = true,
				disable = function(_, bufnr)
					return utils.is_big_file(bufnr)
				end,
			},
			incremental_selection = { enable = true },
			indent = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ak"] = { query = "@block.outer", desc = "around block" },
						["ik"] = { query = "@block.inner", desc = "inside block" },
						["ac"] = { query = "@class.outer", desc = "around class" },
						["ic"] = { query = "@class.inner", desc = "inside class" },
						["a?"] = { query = "@conditional.outer", desc = "around conditional" },
						["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
						["af"] = { query = "@function.outer", desc = "around function " },
						["if"] = { query = "@function.inner", desc = "inside function " },
						["al"] = { query = "@loop.outer", desc = "around loop" },
						["il"] = { query = "@loop.inner", desc = "inside loop" },
						["aa"] = { query = "@parameter.outer", desc = "around argument" },
						["ia"] = { query = "@parameter.inner", desc = "inside argument" },
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]k"] = { query = "@block.outer", desc = "Next block start" },
						["]f"] = { query = "@function.outer", desc = "Next function start" },
						["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]K"] = { query = "@block.outer", desc = "Next block end" },
						["]F"] = { query = "@function.outer", desc = "Next function end" },
						["]A"] = { query = "@parameter.inner", desc = "Next parameter end" },
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[k"] = { query = "@block.outer", desc = "Previous block start" },
						["[f"] = { query = "@function.outer", desc = "Previous function start" },
						["[a"] = { query = "@parameter.inner", desc = "Previous parameter start" },
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[K"] = { query = "@block.outer", desc = "Previous block end" },
						["[F"] = { query = "@function.outer", desc = "Previous function end" },
						["[A"] = { query = "@parameter.inner", desc = "Previous parameter end" },
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						[">K"] = { query = "@block.outer", desc = "Swap next block" },
						[">F"] = { query = "@function.outer", desc = "Swap next function" },
						[">A"] = { query = "@parameter.inner", desc = "Swap next parameter" },
					},
					swap_previous = {
						["<K"] = { query = "@block.outer", desc = "Swap previous block" },
						["<F"] = { query = "@function.outer", desc = "Swap previous function" },
						["<A"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			require("ts_context_commentstring").setup({ enable = true, enable_autocmd = false }) -- Enable commentstring
			vim.g.skip_ts_context_commentstring_module = true -- Increase performance
		end,
	},

	-- tree sitter context
	-- https://github.com/nvim-treesitter/nvim-treesitter-context
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = true,
	},

	--  [hex colors]
	--  https://github.com/NvChad/nvim-colorizer.lua
	{
		"NvChad/nvim-colorizer.lua",
		event = "User BaseFile",
		cmd = {
			"ColorizerToggle",
			"ColorizerAttachToBuffer",
			"ColorizerDetachFromBuffer",
			"ColorizerReloadAllBuffers",
		},
		opts = { user_default_options = { names = false } },
	},
}
