-- Options --------------------------------------------------------------------
vim.opt.breakindent = true -- Wrap indent to match  line start.
vim.opt.clipboard = "unnamedplus" -- Connection to the system clipboard.
vim.opt.cmdheight = 1 -- Hide command line unless needed.
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion.
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting.
vim.opt.cursorline = true -- Highlight the text line of the cursor.
vim.opt.expandtab = true -- Enable the use of space in tab.
vim.opt.fileencoding = "utf-8" -- File content encoding for the buffer.
vim.opt.fillchars = { eob = " " } -- Disable `~` on nonexistent lines.
vim.opt.foldenable = true -- Enable fold for nvim-ufo.
vim.opt.foldlevel = 99 -- set highest foldlevel for nvim-ufo.
vim.opt.foldlevelstart = 99 -- Start with all code unfolded.
vim.opt.foldcolumn = "1" -- Show foldcolumn in nvim 0.9+.
vim.opt.ignorecase = true -- Case insensitive searching.
vim.opt.infercase = true -- Infer cases in keyword completion.

vim.opt.laststatus = 3 -- Globalstatus.
vim.opt.linebreak = true -- Wrap lines at'breakat'.
vim.opt.number = true -- Show numberline.
vim.opt.preserveindent = true -- Preserve indent structure as much as possible.
vim.opt.pumheight = 10 -- Height of the pop up menu.
vim.opt.relativenumber = true -- Show relative numberline.
vim.opt.shiftwidth = 2 -- Number of space inserted for indentation.
vim.opt.showmode = false -- Disable showing modes in command line.
vim.opt.signcolumn = "yes" -- Always show the sign column.
vim.opt.smartcase = true -- Case sensitivie searching.
vim.opt.smartindent = false -- Smarter autoindentation.
vim.opt.splitbelow = true -- Splitting a new window below the current one.
vim.opt.splitright = true -- Splitting a new window at the right of the current one.
vim.opt.tabstop = 4 -- Number of space in a tab.

vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI.
vim.opt.timeoutlen = 500 -- Shorten key timeout length a little bit for which-key.
vim.opt.undofile = true -- Enable persistent undo between session and reboots.
vim.opt.updatetime = 300 -- Length of time to wait before triggering the plugin.
vim.opt.virtualedit = "block" -- Allow going past end of line in visual block mode.
vim.opt.writebackup = false -- Disable making a backup before overwriting a file.
vim.opt.shada = "!,'1000,<50,s10,h" -- Remember the last 1000 opened files
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- Chooses where to store the undodir.
vim.opt.history = 1000 -- Number of commands to remember in a history table (per buffer).
vim.opt.swapfile = false -- Ask what state to recover when opening a file that was not saved.
vim.opt.wrap = true -- Disable wrapping of lines longer than the width of window.
vim.opt.colorcolumn = "80" -- PEP8 like character limit vertical bar.
vim.opt.mousescroll = "ver:1,hor:0" -- Disables hozirontal scroll in neovim.
vim.opt.guicursor = "n:blinkon200,i-ci-ve:ver25" -- Enable cursor blink.
vim.opt.autochdir = true -- Use current file dir as working dir (See project.nvim).
vim.opt.scrolloff = 1000 -- Number of lines to leave before/after the cursor when scrolling. Setting a high value keep the cursor centered.
vim.opt.sidescrolloff = 8 -- Same but for side scrolling.
vim.opt.selection = "old" -- Don't select the newline symbol when using <End> on visual mode.

vim.opt.viewoptions:remove("curdir") -- Disable saving current directory with views.
vim.opt.shortmess:append({ s = true, I = true }) -- Disable startup message.
vim.opt.backspace:append({ "nostop" }) -- Don't stop backspace at insert.
vim.opt.diffopt:append({ "algorithm:histogram", "linematch:60" }) -- Enable linematch diff algorithm

-- Globals --------------------------------------------------------------------
vim.g.mapleader = " " -- Set leader key.
vim.g.maplocalleader = "," -- Set default local leader key.
vim.g.big_file = { size = 1024 * 100, lines = 10000 } -- For files bigger than this, disable 'treesitter' (+100kb).

-- The next globals are toggleable with <space + l + u>
vim.g.autoformat_enabled = false -- Enable auto formatting at start.
vim.g.autopairs_enabled = false -- Enable autopairs at start.
vim.g.cmp_enabled = true -- Enable completion at start.
vim.g.codelens_enabled = true -- Enable automatic codelens refreshing for lsp that support it.
vim.g.diagnostics_mode = 3 -- Set code linting (0=off, 1=only show in status line, 2=virtual text off, 3=all on).
vim.g.icons_enabled = true -- Enable icons in the UI (disable if no nerd font is available).
vim.g.inlay_hints_enabled = false -- Enable always show function parameter names.
vim.g.lsp_round_borders_enabled = true -- Enable round borders for lsp hover and signatureHelp.
vim.g.lsp_signature_enabled = true -- Enable automatically showing lsp help as you write function parameters.
vim.g.notifications_enabled = true -- Enable notifications.
vim.g.semantic_tokens_enabled = true -- Enable lsp semantic tokens at start.
vim.g.url_effect_enabled = true -- Highlight URLs with an underline effect.

-- -- Backspace key
-- vim.opt.backspace = "indent,eol,start"
--
-- -- Search
-- vim.opt.hlsearch = false
-- vim.opt.incsearch = true
-- vim.opt.ignorecase = true -- ignore case in the search patterns
--
-- -- Mouse and scrolling
-- vim.opt.scrolloff = 15
-- vim.opt.sidescrolloff = 8
-- vim.opt.mouse = "a" -- allow the mouse to be used in neovim
--
-- -- Wrapping
-- vim.opt.wrap = false
-- vim.opt.relativenumber = true
-- vim.opt.cursorline = true
-- vim.opt.number = true
-- vim.opt.cursorcolumn = false
-- vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
-- vim.opt.colorcolumn = "120"
--
-- -- Tabs and indentations
-- vim.opt.tabstop = 4
-- vim.bo.tabstop = 4
-- vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
-- vim.opt.smartcase = true
-- vim.opt.smartindent = true
-- vim.opt.showtabline = 0 -- always show tabs
-- vim.opt.expandtab = false -- convert tabs to spaces
--
-- vim.opt.completeopt = { "menuone", "noselect" } -- mostly jsut for cmp TODO comment this out
-- vim.opt.swapfile = false
-- vim.opt.undofile = true
-- vim.opt.linebreak = true
-- vim.opt.laststatus = 3 -- only the last window will always have a status line
-- vim.opt.showcmd = false -- hide (partial) command in the last line of the screen (for performance)
-- vim.opt.ruler = false -- hide the line and column number of the cursor position
-- vim.opt.numberwidth = 4 -- minial number of columns to use for the line number
-- vim.opt.fillchars.eob = " " -- show empty lines at the end of a buffer as ` `
-- vim.opt.shortmess:append("c")
-- vim.opt.whichwrap:append("<,>,[,],h,l")
-- vim.opt.iskeyword:append("-") -- treats word with "-" as single words
-- vim.opt.formatoptions:remove({ "c", "r", "o" }) -- This is a sequence of letters which describes how automatic formatting is to be done
--
-- vim.o.foldcolumn = "1"
-- vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true

-- vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
-- vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵 ", texthl = "DiagnosticSignHint" })
