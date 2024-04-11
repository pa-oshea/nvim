-- EVERY TIME NEOVIM OPENS:
-- Compile lua to bytecode if the nvim version supports it.
if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
	vim.loader.enable()
end

-- THEN:
-- Source config files by order.
for _, source in ipairs({
	"core.options",
	"core.lazy",
	"core.autocmds",
	"core.keymaps",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
	end
end

-- TODO: find out about lsp workspace folders
