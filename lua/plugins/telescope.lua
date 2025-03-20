return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.5",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("telescope").setup({})
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "smart_history")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "harpoon")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>:", builtin.commands, { desc = "Commands" })
		vim.keymap.set("n", "<leader>pf", builtin.git_files, { desc = "Git Files" })
		vim.keymap.set("n", "<leader>pe", builtin.oldfiles, { desc = "Old Files" })

		vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end, { desc = "Search Current Word" })
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end, { desc = "Search Current WORD" })
		vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "Help Tags" })
		vim.keymap.set("n", "<leader>/", builtin.grep_string, { desc = "Grep String" })
	end,
}
