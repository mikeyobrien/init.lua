return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("dashboard").setup({
			theme = "doom",
			config = {
				center = {
					{
						icon = " ",
						icon_hl = "Title",
						desc = "Find File",
						desc_hl = "String",
						key = "<leader>pf",
						key_hl = "Number",
						action = "Telescope find_files",
					},
					{
						icon = " ",
						icon_hl = "Title",
						desc = "Find in Files",
						desc_hl = "String",
						key = "<leader>ps",
						key_hl = "Number",
						action = "Telescope live_grep",
					},
					{
						icon = " ",
						icon_hl = "Title",
						desc = "Recent Files",
						desc_hl = "String",
						key = "<leader>?",
						key_hl = "Number",
						action = "Telescope oldfiles",
					},
					{
						icon = " ",
						icon_hl = "Title",
						desc = "File Browser",
						desc_hl = "String",
						key = "<leader>pv",
						key_hl = "Number",
						action = "Ex",
					},
				},
				footer = {},
			},
		})
	end,
}
