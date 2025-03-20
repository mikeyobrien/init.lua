return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy", -- Load the plugin lazily
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			plugins = {
				marks = true,
				registers = true,
				spelling = { enabled = true },
			},
			window = {
				border = "single",
			},
		},
		config = function()
			local wk = require("which-key")

			wk.setup({
				plugins = {
					marks = true,
					registers = true,
					spelling = { enabled = true },
				},
				win = {
					border = "single",
				},
				triggers = "auto", -- Enable automatic triggering
			})

			-- Only register mappings that aren't handled elsewhere
			wk.register({
				["<leader>"] = {
					u = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
					c = {
						name = "Config",
						r = { function()
							vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
							vim.cmd("nohlsearch")
							vim.cmd("redraw")
							vim.notify("Configuration reloaded!", vim.log.levels.INFO)
						end, "Reload configuration" },
						R = { function()
							-- Sync plugins (update/install/clean)
							vim.cmd("Lazy sync")
							
							-- Clear module cache to force reloading Lua modules
							for name, _ in pairs(package.loaded) do
								if name:match('^plugins%.') or name:match('^config%.') then
									package.loaded[name] = nil
								end
							end
							
							-- Source init.lua
							vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
							
							-- Clear and redraw the screen
							vim.cmd("nohlsearch")
							vim.cmd("redraw")
							
							-- Notify the user
							vim.notify("Full configuration restart completed!", vim.log.levels.INFO)
						end, "Full configuration restart" },
					},
				},
			})
		end,
	},
}
