-- Appearance
vim.opt.termguicolors = true
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.cmdheight = 1 -- more in the neovim command line for displaying messages
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files

-- Files and others
vim.opt.fileencoding = "utf-8" -- the encoding written to a file

-- Split windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Update and backups
vim.opt.backup = false -- creates a backup file
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 1000

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

-- Backspace key
vim.opt.backspace = "indent,eol,start"

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true -- ignore case in the search patterns

-- Mouse and scrolling
vim.opt.scrolloff = 15
vim.opt.sidescrolloff = 8
vim.opt.mouse = "a" -- allow the mouse to be used in neovim

-- Wrapping
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.cursorcolumn = false
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.colorcolumn = "120"

-- Tabs and indentations
vim.opt.tabstop = 4
vim.bo.tabstop = 4
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.showtabline = 0 -- always show tabs
vim.opt.expandtab = false -- convert tabs to spaces

vim.opt.completeopt = { "menuone", "noselect" } -- mostly jsut for cmp TODO comment this out
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.linebreak = true
vim.opt.laststatus = 3 -- only the last window will always have a status line
vim.opt.showcmd = false -- hide (partial) command in the last line of the screen (for performance)
vim.opt.ruler = false -- hide the line and column number of the cursor position
vim.opt.numberwidth = 4 -- minial number of columns to use for the line number
vim.opt.fillchars.eob = " " -- show empty lines at the end of a buffer as ` `
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-") -- treats word with "-" as single words
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- This is a sequence of letters which describes how automatic formatting is to be done

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
