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
        window = {
          border = "single",
        },
        triggers = "auto", -- Enable automatic triggering
      })

      -- Only register mappings that aren't handled elsewhere
      wk.register({
        ["<leader>"] = {
          h = { "<cmd>nohlsearch<cr>", "No Highlight" },
          u = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
        },
      })
    end,
  },
}
