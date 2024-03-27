return {
	--  SNIPPETS ----------------------------------------------------------------
	--  Vim Snippets engine  [snippet engine] + [snippet templates]
	--  https://github.com/L3MON4D3/LuaSnip
	--  https://github.com/rafamadriz/friendly-snippets
	{
		"L3MON4D3/LuaSnip",
		build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"Zeioth/NormalSnippets",
			"benfowler/telescope-luasnip.nvim",
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
			region_check_events = "CursorMoved",
		},
		config = function(_, opts)
			if opts then
				require("luasnip").config.setup(opts)
			end
			vim.tbl_map(function(type)
				require("luasnip.loaders.from_" .. type).lazy_load()
			end, { "vscode", "snipmate", "lua" })
			-- friendly-snippets - enable standardized comments snippets
			require("luasnip").filetype_extend("typescript", { "tsdoc" })
			require("luasnip").filetype_extend("javascript", { "jsdoc" })
			require("luasnip").filetype_extend("lua", { "luadoc" })
			require("luasnip").filetype_extend("python", { "pydoc" })
			require("luasnip").filetype_extend("rust", { "rustdoc" })
			require("luasnip").filetype_extend("cs", { "csharpdoc" })
			require("luasnip").filetype_extend("java", { "javadoc" })
			require("luasnip").filetype_extend("c", { "cdoc" })
			require("luasnip").filetype_extend("cpp", { "cppdoc" })
			require("luasnip").filetype_extend("php", { "phpdoc" })
			require("luasnip").filetype_extend("kotlin", { "kdoc" })
			require("luasnip").filetype_extend("ruby", { "rdoc" })
			require("luasnip").filetype_extend("sh", { "shelldoc" })
		end,
	},

	--  AUTO COMPLETION --------------------------------------------------------
	--  Auto completion engine [autocompletion engine]
	--  https://github.com/hrsh7th/nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
		},
		event = "InsertEnter",
		config = function()
			-- ensure dependencies exist
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			local utils = require("core.utils")

			-- border opts
			local border_opts = {
				border = "none",
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			}

			-- helper
			local function has_words_before()
				local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				enabled = function() -- disable in certain cases on dap.
					local is_buftype_prompt = vim.bo.buftype == "prompt"
					local is_disabled_filetype = utils.is_available("cmp-dap")
						and vim.tbl_contains({ "dap-repl", "dapui_watches", "dapui_hover" }, vim.bo.filetype)

					if not is_disabled_filetype or is_buftype_prompt then
						return vim.g.cmp_enabled
					else
						return false
					end
				end,
				preselect = cmp.PreselectMode.None,
				formatting = {
					-- fields = { "menu", "kind", "abbr" },
					-- format = lspkind.cmp_format(utils.plugin_opts("lspkind.nvim")),
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "     " .. (strings[2] or "") .. " "

						return kind
					end,
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				duplicates = {
					nvim_lsp = 1,
					luasnip = 1,
					cmp_tabnine = 1,
					buffer = 1,
					path = 1,
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				window = {
					completion = cmp.config.window.bordered(utils.extend_tbl(border_opts, {
						col_offset = -3,
						side_padding = 0,
					})),
					documentation = cmp.config.window.bordered(border_opts),
				},
				mapping = {
					["<PageUp>"] = cmp.mapping.select_prev_item({
						behavior = cmp.SelectBehavior.Select,
						count = 8,
					}),
					["<PageDown>"] = cmp.mapping.select_next_item({
						behavior = cmp.SelectBehavior.Select,
						count = 8,
					}),
					["<C-PageUp>"] = cmp.mapping.select_prev_item({
						behavior = cmp.SelectBehavior.Select,
						count = 16,
					}),
					["<C-PageDown>"] = cmp.mapping.select_next_item({
						behavior = cmp.SelectBehavior.Select,
						count = 16,
					}),
					["<S-PageUp>"] = cmp.mapping.select_prev_item({
						behavior = cmp.SelectBehavior.Select,
						count = 16,
					}),
					["<S-PageDown>"] = cmp.mapping.select_next_item({
						behavior = cmp.SelectBehavior.Select,
						count = 16,
					}),
					["<Up>"] = cmp.mapping.select_prev_item({
						behavior = cmp.SelectBehavior.Select,
					}),
					["<Down>"] = cmp.mapping.select_next_item({
						behavior = cmp.SelectBehavior.Select,
					}),
					["<C-p>"] = cmp.mapping.select_prev_item({
						behavior = cmp.SelectBehavior.Insert,
					}),
					["<C-n>"] = cmp.mapping.select_next_item({
						behavior = cmp.SelectBehavior.Insert,
					}),
					["<C-k>"] = cmp.mapping.select_prev_item({
						behavior = cmp.SelectBehavior.Insert,
					}),
					["<C-j>"] = cmp.mapping.select_next_item({
						behavior = cmp.SelectBehavior.Insert,
					}),
					["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable,
					["<C-e>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 750 },
					{ name = "buffer", priority = 500 },
					{ name = "nvim_lua", priority = 300 },
					{ name = "path", priority = 250 },
				}),
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
