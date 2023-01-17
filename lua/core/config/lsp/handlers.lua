local M = {}

local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Adds additional functinality to the lsp client. E.g: completion, snippetSupport, code folding
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- ufo folding
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	-- https://neovim.io/doc/user/diagnostic.html#diagnostic-api
	local config = {
		severity_sort = true,
		float = {
			border = "single",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- bm.nkeymap("gd", vim.lsp.buf.definition, "Definition")
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gF", "<cmd>Lspsaga lsp_finder<cr>", bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, bufopts)
	vim.keymap.set("n", "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	vim.keymap.set("n", "<leader>ll", vim.lsp.codelens.run, bufopts)
	vim.keymap.set("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", bufopts)
	vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", bufopts)
	vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", bufopts)
	vim.keymap.set("n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<cr>", bufopts)
	vim.keymap.set("n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", bufopts)
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>lh", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", bufopts)
	vim.keymap.set("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", bufopts)
	vim.keymap.set("n", "<leader>le", "<cmd>Telescope quickfix<cr>", bufopts)
	vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, bufopts)
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "gopls" then
		client.server_capabilities.documentFormattingProvider = false
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end
	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return M
