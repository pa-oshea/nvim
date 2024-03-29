return {
	--  DEBUGGER ----------------------------------------------------------------
	--  Debugger alternative to vim-inspector [debugger]
	--  https://github.com/mfussenegger/nvim-dap
	--  Here we configure the adapter+config of every debugger.
	--  Debuggers don't have system dependencies, you just install them with mason.
	--  We currently ship most of them with nvim.
	{
		"mfussenegger/nvim-dap",
		enabled = vim.fn.has("win32") == 0,
		event = "User BaseFile",
		config = function()
			local dap = require("dap")

			-- C#
			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
				args = { "--interpreter=vscode" },
			}
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function() -- Ask the user what executable wants to debug
						return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Program.exe", "file")
					end,
				},
			}

			-- F#
			dap.configurations.fsharp = dap.configurations.cs

			-- Visual basic dotnet
			dap.configurations.vb = dap.configurations.cs

			-- Java
			-- Note: The java debugger jdtls is automatically spawned and configured
			-- when a java file is opened by the plugin nvim-java.

			-- Python
			dap.adapters.python = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
				args = { "-m", "debugpy.adapter" },
			}
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}", -- This configuration will launch the current file if used.
				},
			}

			-- Lua
			dap.adapters.nlua = function(callback, config)
				callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
			end
			dap.configurations.lua = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
					program = function()
						pcall(require("osv").launch({ port = 8086 }))
					end,
				},
			}

			-- C
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
					detached = true,
				},
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function() -- Ask the user what executable wants to debug
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/program", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}

			-- C++
			dap.configurations.cpp = dap.configurations.c

			-- Rust
			dap.configurations.rust = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function() -- Ask the user what executable wants to debug
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/program", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					initCommands = function() -- add rust types support (optional)
						-- Find out where to look for the pretty printer Python module
						local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

						local script_import = 'command script import "'
							.. rustc_sysroot
							.. '/lib/rustlib/etc/lldb_lookup.py"'
						local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

						local commands = {}
						local file = io.open(commands_file, "r")
						if file then
							for line in file:lines() do
								table.insert(commands, line)
							end
							file:close()
						end
						table.insert(commands, 1, script_import)

						return commands
					end,
				},
			}

			-- Go
			-- Requires:
			-- * You have initialized your module with 'go mod init module_name'.
			-- * You :cd your project before running DAP.
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/packages/delve/dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}
			dap.configurations.go = {
				{
					type = "delve",
					name = "Compile module and debug this file",
					request = "launch",
					program = "./${relativeFileDirname}",
				},
				{
					type = "delve",
					name = "Compile module and debug this file (test)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}

			-- Dart / Flutter
			dap.adapters.dart = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
				args = { "dart" },
			}
			dap.adapters.flutter = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
				args = { "flutter" },
			}
			dap.configurations.dart = {
				{
					type = "dart",
					request = "launch",
					name = "Launch dart",
					dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/", -- ensure this is correct
					flutterSdkPath = "/opt/flutter", -- ensure this is correct
					program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
					cwd = "${workspaceFolder}",
				},
				{
					type = "flutter",
					request = "launch",
					name = "Launch flutter",
					dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/", -- ensure this is correct
					flutterSdkPath = "/opt/flutter", -- ensure this is correct
					program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
					cwd = "${workspaceFolder}",
				},
			}

			-- Kotlin
			-- Kotlin projects have very weak project structure conventions.
			-- You must manually specify what the project root and main class are.
			dap.adapters.kotlin = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/kotlin-debug-adapter",
			}
			dap.configurations.kotlin = {
				{
					type = "kotlin",
					request = "launch",
					name = "Launch kotlin program",
					projectRoot = "${workspaceFolder}/app", -- ensure this is correct
					mainClass = "AppKt", -- ensure this is correct
				},
			}

			-- Javascript / Typescript (firefox)
			dap.adapters.firefox = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/firefox-debug-adapter",
			}
			dap.configurations.typescript = {
				{
					name = "Debug with Firefox",
					type = "firefox",
					request = "launch",
					reAttach = true,
					url = "http://localhost:4200", -- Write the actual URL of your project.
					webRoot = "${workspaceFolder}",
					firefoxExecutable = "/usr/bin/firefox",
				},
			}
			dap.configurations.javascript = dap.configurations.typescript
			dap.configurations.javascriptreact = dap.configurations.typescript
			dap.configurations.typescriptreact = dap.configurations.typescript

			-- Javascript / Typescript (chromium)
			-- If you prefer to use this adapter, comment the firefox one.
			-- But to use this adapter, you must manually run one of these two, first:
			-- * chromium --remote-debugging-port=9222 --user-data-dir=remote-profile
			-- * google-chrome-stable --remote-debugging-port=9222 --user-data-dir=remote-profile
			-- After starting the debugger, you must manually reload page to get all features.
			-- dap.adapters.chrome = {
			--  type = 'executable',
			--  command = vim.fn.stdpath('data')..'/mason/bin/chrome-debug-adapter',
			-- }
			-- dap.configurations.typescript = {
			--  {
			--   name = 'Debug with Chromium',
			--   type = "chrome",
			--   request = "attach",
			--   program = "${file}",
			--   cwd = vim.fn.getcwd(),
			--   sourceMaps = true,
			--   protocol = "inspector",
			--   port = 9222,
			--   webRoot = "${workspaceFolder}"
			--  }
			-- }
			-- dap.configurations.javascript = dap.configurations.typescript
			-- dap.configurations.javascriptreact = dap.configurations.typescript
			-- dap.configurations.typescriptreact = dap.configurations.typescript

			-- PHP
			dap.adapters.php = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
			}
			dap.configurations.php = {
				{
					type = "php",
					request = "launch",
					name = "Listen for Xdebug",
					port = 9000,
				},
			}

			-- Shell
			dap.adapters.bashdb = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
				name = "bashdb",
			}
			dap.configurations.sh = {
				{
					type = "bashdb",
					request = "launch",
					name = "Launch file",
					showDebugOutput = true,
					pathBashdb = vim.fn.stdpath("data")
						.. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
					pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
					trace = true,
					file = "${file}",
					program = "${file}",
					cwd = "${workspaceFolder}",
					pathCat = "cat",
					pathBash = "/bin/bash",
					pathMkfifo = "mkfifo",
					pathPkill = "pkill",
					args = {},
					env = {},
					terminalKind = "integrated",
				},
			}

			-- Elixir
			dap.adapters.mix_task = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/elixir-ls-debugger",
				args = {},
			}
			dap.configurations.elixir = {
				{
					type = "mix_task",
					name = "mix test",
					task = "test",
					taskArgs = { "--trace" },
					request = "launch",
					startApps = true, -- for Phoenix projects
					projectDir = "${workspaceFolder}",
					requireFiles = {
						"test/**/test_helper.exs",
						"test/**/*_test.exs",
					},
				},
			}
		end, -- of dap config
		dependencies = {
			{
				"jay-babu/mason-nvim-dap.nvim",
				"jbyuki/one-small-step-for-vimkind",
				"nvim-java/nvim-java",
				dependencies = { "nvim-dap" },
				cmd = { "DapInstall", "DapUninstall" },
				opts = { handlers = {} },
			},
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
				-- icons = { expanded = "", collapsed = "", circular = "" }
				opts = { floating = { border = "rounded" } },
				config = function(_, opts)
					local dap, dapui = require("dap"), require("dapui")
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
					dapui.setup(opts)
				end,
			},
			{
				"rcarriga/cmp-dap",
				dependencies = { "nvim-cmp" },
				config = function()
					require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
						sources = {
							{ name = "dap" },
						},
					})
				end,
			},
		},
	},
}
