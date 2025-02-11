return {
    {
      name = 'amazonq',
      url = 'ssh://git.amazon.com/pkg/AmazonQNVim',
      config = function()
        local q = require("amazonq")
        require('amazonq').setup({
          ssoStartUrl = 'https://amzn.awsapps.com/start',
        })
        vim.keymap.set("n", "<leader>qq", ":AmazonQChat<CR>",
          { desc = "Toggle QChat" })
        vim.keymap.set("n", "<leader>qQ", ":AmazonQClear<CR>",
          { desc = "Toggle QChat" })
        vim.keymap.set("v", "<leader>qe", ":AmazonQExplain<CR>",
          { desc = "Explain code" })
        vim.keymap.set("v", "<leader>qf", ":AmazonQFix<CR>",
          { desc = "Fix code" })
        vim.keymap.set("v", "<leader>qr", ":AmazonQRefactor<CR>",
          { desc = "Refactor code" })
        vim.keymap.set("n", "<leader>q?", ":AmazonQHelp<CR>",
          { desc = "Q help" })

      end
    },
}
