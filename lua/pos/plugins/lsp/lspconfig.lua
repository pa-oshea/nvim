return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	opts = {
		-- options for vim.diagnostic.config()
		diagnostics = {
			underline = false,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
				-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
				-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
				-- prefix = "icons",
			},
			severity_sort = true,
		},
		-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
		-- Be aware that you also will need to properly configure your LSP server to
		-- provide the inlay hints.
		inlay_hints = {
			enabled = false,
		},
		-- add any global capabilities here
		capabilities = {},
		-- options for vim.lsp.buf.format
		-- `bufnr` and `filter` is handled by the LazyVim formatter,
		-- but can be also overridden when specified
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
		-- LSP Server Settings
		---@type lspconfig.options
		servers = {
			lua_ls = {
				-- mason = false, -- set to false if you don't want this server to be installed with mason
				-- Use this to add any additional keymaps
				-- for specific lsp servers
				---@type LazyKeysSpec[]
				-- keys = {},
				settings = {
					Lua = {},
				},
			},
		},
	},
	config = function()
		local lspui = require("lspconfig.ui.windows")

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.diagnostic.config(vim.deepcopy({
			underline = true,
			update_in_insert = false,
			virtual_text = {
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
		}))
		--LspInfo Borders
		lspui.default_options.border = "double"

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				-- TODO: Find out more about these
				-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
				-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
				-- vim.keymap.set("n", "<space>wl", function()
				-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				-- end, opts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			end,
		})
	end,
}
