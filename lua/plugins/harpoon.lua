return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- Keybindings
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end,
      { desc = "Harpoon add file" })
    vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon toggle menu" })

    -- Quick file navigation
    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end,
      { desc = "Harpoon file 1" })
    vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end,
      { desc = "Harpoon file 2" })
    vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end,
      { desc = "Harpoon file 3" })
    vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end,
      { desc = "Harpoon file 4" })

    -- Navigation between marks
    vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end,
      { desc = "Next harpoon mark" })
    vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end,
      { desc = "Previous harpoon mark" })
  end,
}
