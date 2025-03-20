return {
  -- In-editor Markdown preview
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "markdown" },
    keys = {
      { "<leader>mp", "<cmd>RenderMarkdown<CR>", desc = "Toggle Markdown Preview" },
    },
    config = function()
      require("render-markdown").setup({
        -- Default options
        -- highlight = {
        --   enable = true,
        --   inline = true,
        -- },
      })
    end,
  },

  -- Enhanced Markdown syntax highlighting and features
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
    dependencies = { "godlygeek/tabular" }, -- Required dependency
    config = function()
      -- Disable folding
      vim.g.vim_markdown_folding_disabled = 1
      -- Don't insert indent when entering a new list item
      vim.g.vim_markdown_new_list_item_indent = 0
      -- Support front-matter in markdown files
      vim.g.vim_markdown_frontmatter = 1
      -- Support TOML front-matter
      vim.g.vim_markdown_toml_frontmatter = 1
      -- Support JSON front-matter
      vim.g.vim_markdown_json_frontmatter = 1
      -- Don't conceal links
      vim.g.vim_markdown_conceal_links = 0
    end,
  },

  -- Markdown filetype settings
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = opts.ensure_installed or {}
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
        end
      end
    end,
  },
  
  -- Add autocmd for markdown filetype settings
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          -- Enable spell checking
          vim.opt_local.spell = true
          -- Enable word wrapping
          vim.opt_local.wrap = true
          -- Enable line breaks on words
          vim.opt_local.linebreak = true
          -- Use 2 spaces for indentation
          vim.opt_local.tabstop = 2
          vim.opt_local.softtabstop = 2
          vim.opt_local.shiftwidth = 2
          -- Add convenient mappings for markdown
          vim.keymap.set("n", "<leader>mb", "ysiw*", { buffer = true, desc = "Make word bold" })
          vim.keymap.set("n", "<leader>mi", "ysiw_", { buffer = true, desc = "Make word italic" })
          -- Set textwidth for automatic formatting
          vim.opt_local.textwidth = 80
          -- Enable concealing of formatting markers
          vim.opt_local.conceallevel = 2
        end,
      })
    end,
  },
}
