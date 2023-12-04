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

require("lazy").setup({
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme tokyonight-night]])
	-- 	end,
	-- },
	-- {
	-- 	"neanias/everforest-nvim",
	-- 	lazy = false,
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	-- Optional; default configuration will be used if setup isn't called.
	-- 	config = function()
	-- 		require("everforest").setup({
	-- 			-- Your config here
	-- 		})
	-- 		vim.cmd([[colorscheme everforest]])
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin-frappe]])
		end,
	},
	{ "fladson/vim-kitty" },
	-- {
	-- 	"AlexvZyl/nordic.nvim",
	-- 	config = function()
	-- 		vim.cmd([[colorscheme nordic]])
	-- 	end,
	-- },

	-- https://github.com/folke/which-key.nvim
	{
		"folke/which-key.nvim",
		config = function()
			require("core.config.which-key").setup()
		end,
		event = "VeryLazy",
	},

	-- LSP Support
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jayp0521/mason-nvim-dap.nvim" },
	{ "onsails/lspkind.nvim" },
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
	},
	{ "jose-elias-alvarez/null-ls.nvim" },
	{
		"folke/lsp-colors.nvim",
		config = function()
			require("lsp-colors").setup()
		end,
	},

	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
		tag = "legacy",
	},

	{ "folke/neodev.nvim" },

	-- https://github.com/SmiteshP/nvim-navic
	{
		"SmiteshP/nvim-navic",
		config = function()
			require("core.config.lsp.navic").setup()
		end,
	},
	-- A fancy, configurable, notification manager for NeoVim
	-- https://github.com/rcarriga/nvim-notify
	{ "rcarriga/nvim-notify" },

	-- Dev Icons
	{ "kyazdani42/nvim-web-devicons" },

	-- ui component library
	{ "MunifTanjim/nui.nvim" },

	-- Lualine https://github.com/nvim-lualine/lualine.nvim
	{ "nvim-lualine/lualine.nvim" },

	-- Bufferline https://github.com/akinsho/bufferline.nvim
	{ "akinsho/bufferline.nvim" },

	-- neo tree https://github.com/nvim-neo-tree/neo-tree.nvim
	{ "nvim-neo-tree/neo-tree.nvim" },

	-- alpha https://github.com/goolord/alpha-nvim
	{ "goolord/alpha-nvim" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" },

	-- https://github.com/p00f/nvim-ts-rainbow
	{ "p00f/nvim-ts-rainbow" },

	-- https://github.com/andymass/vim-matchup
	{ "andymass/vim-matchup" },

	-- https://github.com/nvim-treesitter/nvim-treesitter-context
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	},

	-- Autocompletion
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	-- Snippets
	{ "L3MON4D3/LuaSnip" },
	-- Snippet Collection (Optional)
	{ "rafamadriz/friendly-snippets" },

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			require("core.config.telescope").setup()
		end,
		lazy = true,
		cmd = "Telescope",
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		lazy = true,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		lazy = true,
		build = "make",
	},

	-- Auto pairs https://github.com/windwp/nvim-autopairs
	{ "windwp/nvim-autopairs" },

	-- Nvim surround https://github.com/kylechui/nvim-surround
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	-- Nvim comment https://github.com/terrortylor/nvim-comment
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup()
		end,
	},

	-- https://github.com/norcalli/nvim-colorizer.lua
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- https://github.com/lewis6991/gitsigns.nvim
	{ "lewis6991/gitsigns.nvim" },

	-- https://github.com/lukas-reineke/indent-blankline.nvim
	{ "lukas-reineke/indent-blankline.nvim" },

	-- https://github.com/RRethy/vim-illuminate
	{ "RRethy/vim-illuminate" },

	-- https://github.com/folke/zen-mode.nvim
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup()
		end,
	},

	-- Folding https://github.com/kevinhwang91/nvim-ufo
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
	},

	-- lua functions for neovim
	-- https://github.com/nvim-lua/plenary.nvim
	{ "nvim-lua/plenary.nvim" },

	-- https://github.com/mbbill/undotree
	{ "mbbill/undotree" },

	-- https://github.com/sindrets/diffview.nvim
	{ "sindrets/diffview.nvim" },

	-- https://github.com/ahmedkhalf/project.nvim
	{ "ahmedkhalf/project.nvim" },

	-- https://github.com/simrat39/symbols-outline.nvim
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	},

	-- neo test https://github.com/nvim-neotest/neotest#usage
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/neotest-go",
			"haydenmeade/neotest-jest",
		},
	},

	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui" },
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
	},

	-- trouble https://github.com/folke/trouble.nvim
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
	},
	-- todo comments https://github.com/folke/todo-comments.nvim
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPost",
		config = true,
	},
	-- Selected window is shown better
	-- FIXME: diffview breaks this
	-- {
	-- 	"sunjon/shade.nvim",
	-- 	config = function()
	-- 		require("shade").setup()
	-- 	end,
	-- },

	{ "mfussenegger/nvim-jdtls" },
	{
		"Wansmer/treesj",
		keys = { "<space>m", "<space>j", "<space>k" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({})
		end,
	},
	-- {
	-- 	"m4xshen/hardtime.nvim",
	-- 	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("hardtime").setup()
	-- 	end,
	-- },
})
