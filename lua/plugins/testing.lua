return {

	--  TESTING -----------------------------------------------------------------
	--  Run tests inside of nvim [unit testing]
	--  https://github.com/nvim-neotest/neotest
	--
	--
	--  MANUAL:
	--  -- Unit testing:
	--  To tun an unit test you can run any of these commands:
	--
	--    :Neotest run      -- Runs the nearest test to the cursor.
	--    :Neotest stop     -- Stop the nearest test to the cursor.
	--    :Neotest run file -- Run all tests in the file.
	--
	--  -- E2e and Test Suite
	--  Normally you will prefer to open your e2e framework GUI outside of nvim.
	--  But you have the next commands in ../base/3-autocmds.lua:
	--
	--    :TestNodejs    -- Run all tests for this nodejs project.
	--    :TestNodejsE2e -- Run the e2e tests/suite for this nodejs project.
	{
		"nvim-neotest/neotest",
		cmd = { "Neotest" },
		dependencies = {
			"nvim-neotest/neotest-go",
			"rcasia/neotest-java",
			"nvim-neotest/neotest-jest",
			"rouge8/neotest-rust",
			"lawrence-laz/neotest-zig",
		},
		opts = function()
			return {
				-- your neotest config here
				adapters = {
					require("neotest-go"),
					require("neotest-java"),
					require("neotest-jest"),
					require("neotest-rust"),
					require("neotest-zig"),
				},
			}
		end,
		config = function(_, opts)
			-- get neotest namespace (api call creates or returns namespace)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			require("neotest").setup(opts)
		end,
	},

	--  Shows a float panel with the [code coverage]
	--  https://github.com/andythigpen/nvim-coverage
	--
	--  Your project must generate coverage/lcov.info for this to work.
	--
	--  On jest, make sure your packages.json file has this:
	--  "tests": "jest --coverage"
	--
	--  If you use other framework or language, refer to nvim-coverage docs:
	--  https://github.com/andythigpen/nvim-coverage/blob/main/doc/nvim-coverage.txt
	{
		"andythigpen/nvim-coverage",
		cmd = {
			"Coverage",
			"CoverageLoad",
			"CoverageLoadLcov",
			"CoverageShow",
			"CoverageHide",
			"CoverageToggle",
			"CoverageClear",
			"CoverageSummary",
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("coverage").setup()
		end,
	},

	-- TODO: Move to lang file
	-- LANGUAGE IMPROVEMENTS ----------------------------------------------------
	-- guttentags_plus [auto generate C/C++ tags]
	-- https://github.com/skywind3000/gutentags_plus
	-- This plugin is necessary for using <C-]> (go to ctag).
	{
		"skywind3000/gutentags_plus",
		ft = { "c", "cpp" },
		dependencies = { "ludovicchabant/vim-gutentags" },
		init = function()
			vim.g.gutentags_plus_nomap = 1
			vim.g.gutentags_resolve_symlinks = 1
			vim.g.gutentags_cache_dir = vim.fn.stdpath("cache") .. "/tags"
			vim.api.nvim_create_autocmd("FileType", {
				desc = "Auto generate C/C++ tags",
				callback = function()
					local is_c = vim.bo.filetype == "c" or vim.bo.filetype == "cpp"
					if is_c then
						vim.g.gutentags_enabled = 1
					else
						vim.g.gutentags_enabled = 0
					end
				end,
			})
		end,
	},
}
