local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	git = {
		clone_timeout = 300, -- Timeout, in seconds, for git clones
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- TODO too look at
	-- b0o/schemastore.nvim
	-- lunarvim/bigfile.nvim
	-- kevinhwang91/nvim-bqf
	-- tamago324/nlsp-settings.nvim
	-- Tastyep/structlog.nvim
	-- stevearc/aerial.nvim
	-- Shatur/neovim-session-manager
	--
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("moll/vim-bbye") -- TODO Maybe delete this
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("mbbill/undotree")

	-- Colorschemes
	use("folke/tokyonight.nvim")
	use("nyoom-engineering/oxocarbon.nvim")
	use({ "decaycs/decay.nvim", as = "decay" })

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- Mason
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jayp0521/mason-nvim-dap.nvim")

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("ray-x/lsp_signature.nvim")
	use("folke/trouble.nvim")
	use("j-hui/fidget.nvim")
	use("glepnir/lspsaga.nvim")
	use("folke/neodev.nvim", { module = "neodev" })
	use("onsails/lspkind-nvim")

	-- UI / interface
	use("RRethy/vim-illuminate")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("rcarriga/nvim-notify")
	use("stevearc/dressing.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("akinsho/bufferline.nvim")
	use("folke/lsp-colors.nvim")
	use("simrat39/symbols-outline.nvim")
	use("mrjones2014/smart-splits.nvim")
	use("SmiteshP/nvim-navic")
	use("nvim-lualine/lualine.nvim")
	use("akinsho/toggleterm.nvim")
	use("sitiom/nvim-numbertoggle")
	use("norcalli/nvim-colorizer.lua")
	use({
		"melkster/modicator.nvim",
		after = "tokyonight.nvim", -- Add your colorscheme plugin here
		setup = function()
			-- These are required for Modicator to work
			vim.o.cursorline = true
			vim.o.number = true
			vim.o.termguicolors = true
		end,
		config = function()
			require("modicator").setup({
				-- ...
			})
		end,
	})

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-ui-select.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter", {
		run = ":TSUpdate",
	})
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("p00f/nvim-ts-rainbow")
	use("andymass/vim-matchup")
	use("RRethy/nvim-treesitter-textsubjects")
	use("nvim-treesitter/nvim-treesitter-context")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("sindrets/diffview.nvim")

	-- DAP
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")

	-- which key
	use("folke/which-key.nvim")

	-- Shortcuts
	use("famiu/bufdelete.nvim")
	use("kylechui/nvim-surround") -- Surround text with delimiters such as brackets and quotes
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("max397574/better-escape.nvim")
	use("kevinhwang91/nvim-ufo")
	use("kevinhwang91/promise-async")

	-- Go lang stuff
	use("olexsmir/gopher.nvim")
	use("leoluz/nvim-dap-go")
	-- use("ray-x/go.nvim")
	-- use("ray-x/guihua.lua")

	use("ThePrimeagen/vim-be-good")

	-- zen mode
	-- use({
	-- 	"folke/zen-mode.nvim",
	-- 	config = function()
	-- 		require("zen-mode").setup({
	-- 			-- your configuration comes here
	-- 			-- or leave it empty to use the default settings
	-- 			-- refer to the configuration section below
	-- 		})
	-- 	end,
	-- }) --

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
