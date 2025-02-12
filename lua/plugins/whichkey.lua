return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load the plugin lazily
    config = function()
      local wk = require("which-key")

      -- Basic setup for which-key
      wk.setup({
        plugins = {
          marks = true, -- Enable marks (e.g., `m` mappings)
          registers = true, -- Enable register mappings
          spelling = { enabled = true }, -- Enable spelling suggestions
        },
        window = {
          border = "single", -- Add a border to the which-key window
        },
      })

      -- Define your keybindings here
      wk.register({
        ["<leader>"] = {
          f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- Example mapping
          g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
          h = { "<cmd>nohlsearch<cr>", "No Highlight" }, -- Clear search highlights
          u = { "<cmd>UndotreeToggle<cr>", "Undo Tree" }, -- Toggle undotree
        },
      })
    end,
  },
}
