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
    config = function(_, opts)
      local wk = require("which-key")

      -- Setup which-key with the opts
      wk.setup(opts)

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
