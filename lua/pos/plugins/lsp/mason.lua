return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				border = "single",
				width = 0.8,
				height = 0.8,
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = cmp_nvim_lsp.default_capabilities()

			require("mason-lspconfig").setup({
				-- auto installation
				automatic_installation = true,
			})
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				--- go lsp
				["gopls"] = function()
					lspconfig.gopls.setup({
						capabilities = capabilities,
						on_attach = function(client, _)
							if client.name == "gopls" then
								if not client.server_capabilities.semanticTokensProvider then
									local semantic = client.config.capabilities.textDocument.semanticTokens
									client.server_capabilities.semanticTokensProvider = {
										full = true,
										legend = {
											tokenTypes = semantic.tokenTypes,
											tokenModifiers = semantic.tokenModifiers,
										},
										range = true,
									}
								end
							end
						end,
						settings = {
							gopls = {
								gofumpt = true,
								codelenses = {
									gc_details = false,
									generate = true,
									regenerate_cgo = true,
									run_govulncheck = true,
									test = true,
									tidy = true,
									upgrade_dependency = true,
									vendor = true,
								},
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
								analyses = {
									fieldalignment = true,
									nilness = true,
									unusedparams = true,
									unusedwrite = true,
									useany = true,
								},
								usePlaceholders = true,
								completeUnimported = true,
								staticcheck = true,
								directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
								semanticTokens = true,
							},
						},
					})
				end,

				-- typescript / javascript
				["tsserver"] = function()
					lspconfig.tsserver.setup({
						capabilities = capabilities,
						settings = {
							typescript = {
								format = {
									indentSize = vim.o.shiftwidth,
									convertTabsToSpaces = vim.o.expandtab,
									tabSize = vim.o.tabstop,
								},
							},
							javascript = {
								format = {
									indentSize = vim.o.shiftwidth,
									convertTabsToSpaces = vim.o.expandtab,
									tabSize = vim.o.tabstop,
								},
							},
							completions = {
								completeFunctionCalls = true,
							},
						},
					})
				end,

				-- lua lsp
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
								runtime = {
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
									},
								},
							},
						},
					})
				end,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			ensure_installed = {
				"bashls",
				"cssls",
				{ "delve", auto_update = false },
				"eslint_d",
				"gopls",
				"goimports",
				"gofumpt",
				"golangci-lint",
				"gomodifytags",
				"html-lsp",
				"impl",
				"java-test",
				"java-debug-adapter",
				"jdtls",
				"json-lsp",
				"js-debug-adapter",
				"lua_ls",
				"marksman",
				"node-debug2-adapter",
				"prettierd",
				"stylua",
				"tsserver",
				"tailwindcss-language-server",
				"vimls",
			},
			auto_update = true,
			run_on_start = true,
			start_delay = 3000, -- 3 second delay
			debounce_hours = 5, -- at least 5 hours between attempts to install/update
		},
	},
}
