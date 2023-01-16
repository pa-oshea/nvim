local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local editor = require("core.plugins.editor")
local tools = require("core.plugins.tools")
local treesitter = require("core.plugins.treesitter")
local telescope = require("core.plugins.telescope")
local ui = require("core.plugins.ui")
local lsp = require("core.plugins.lsp")
local dap = require("core.plugins.dap")
local cmp = require("core.plugins.cmp")

require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},

	-- https://github.com/folke/which-key.nvim
	{
		"folke/which-key.nvim",
		priority = 500,
		config = function()
			local wk_status, wk = pcall(require, "which-key")
			if not wk_status then
				vim.notify("which key failed to load", "error")
				return
			end

			wk.setup({
				icons = {
					-- symbol used in the command line area that shows your active key combo
					breadcrumb = "»",
					-- symbol used between a key and it's label
					separator = "➜",
					-- symbol prepended to a group
					group = "…",
				},
				spelling = { enabled = true, suggestions = 50 },
			})
		end,
	},
	ui,
	treesitter,
	cmp,
	lsp,
	telescope,
	editor,
	tools,
	dap,
})
