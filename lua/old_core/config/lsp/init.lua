require("neodev").setup({
	library = {
		plugin = {
			"neotest",
		},
		types = true,
	},
})
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("Lsp not working", "error")
	return
end

require("core.config.lsp.mason")

local servers = require("core.config.lsp.servers")
local opts = {}
-- TODO Move this somewhere?
for _, server in pairs(servers) do
	opts = {
		on_attach = require("core.config.lsp.handlers").on_attach,
		capabilities = require("core.config.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	-- add addtional settings to the lsp server from the settings folder
	local require_ok, conf_opts = pcall(require, "core.config.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

require("core.config.lsp.handlers").setup()
require("core.config.lsp.null_ls")
require("core.config.lsp.lspsaga")
require("ufo").setup()
