return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local lspui = require("lspconfig.ui.windows")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		--LspInfo Borders
		lspui.default_options.border = "double"

		-- Managing language servers individually
		-- tsserver
		lspconfig.tsserver.setup({
			capabilities = capabilities,
		})
		-- rust_analyzer
		-- lspconfig.rust_analyzer.setup({
		-- 	capabilities = capabilities,
		-- 	-- Server-specific settings. See `:help lspconfig-setup`
		-- 	settings = {
		-- 		["rust-analyzer"] = {},
		-- 	},
		-- })
		lspconfig.gopls.setup({
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
		})
		-- html
		lspconfig.html.setup({
			capabilities = capabilities,
		})
		-- configure emmet language server
		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- Lua LS
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							vim.env.VIMRUNTIME,
						},
					},
				},
			},
		})

		-- CSS LS
		lspconfig.cssls.setup({
			capabilities = capabilities,
		})

		-- Tailwind
		-- Support for tailwind auto completion
		-- install the tailwind server : "sudo npm install -g @tailwindcss/language-server"
		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
		})

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
				vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			end,
		})
	end,
}
