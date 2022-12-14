return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "packer_plugins" },
			},
			runtime = {
				version = "LuaJIT",
				special = {
					reload = "require",
				},
			},
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME"),
					require("neodev.config").types(),
					-- vim.fn.stdpath("data"), -- FIXME find out if these are needed
					-- vim.fn.stdpath("config"),
					"${3rd}/busted/library",
					"${3rd}/luassert/library",
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
