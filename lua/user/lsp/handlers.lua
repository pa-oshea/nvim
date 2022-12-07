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
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	-- https://neovim.io/doc/user/diagnostic.html#diagnostic-api
	-- Defaults
	-- virtual_text = true
	-- signs = {
	--      active = signs
	-- }
	-- update_in_insert = false,
	-- underline = true,
	-- float = { style = "minimal", header = "", prefix = ""}
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
	local km = require("user.utils.keymapper")
	local bm = km.create_bufkeymapper(bufnr)
	-- bm.nkeymap("gD", function()
	-- 	vim.cmd("tab split")
	-- 	vim.lsp.buf.declaration()
	-- end, "Declaration")
	bm.nkeymap("gd", "<cmd>Lspsaga lsp_finder<cr>", "Definition")
	bm.nkeymap("K", vim.lsp.buf.hover, "Lsp hover")
	bm.nkeymap("gI", vim.lsp.buf.implementation, "Implementation")
	-- bm.nkeymap("gr", vim.lsp.buf.references, "References")
	bm.nkeymap("gl", vim.diagnostic.open_float, "Open diagnostic float")
	km.wk.register({ ["<leader>l"] = { name = "Lsp" } }, { mode = "n", buffer = bufnr })
	bm.nkeymap("<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, "Format buffer")
	bm.nkeymap("<leader>li", "<cmd>LspInfo<cr>", "Lsp info")
	bm.nkeymap("<leader>la", "<cmd>Lspsaga code_action<cr>", "Code action")
	bm.nkeymap("<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next diagnostic")
	bm.nkeymap("<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Previous diagnostic")
	bm.nkeymap("<leader>lr", vim.lsp.buf.rename, "Rename")
	bm.nkeymap("<leader>ls", vim.lsp.buf.signature_help, "Signature help")
	bm.nkeymap("<leader>lq", vim.diagnostic.setloclist, "Set loclist")
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
