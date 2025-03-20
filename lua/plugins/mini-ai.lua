return {
  "echasnovski/mini.ai",
  version = false,
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local ai = require("mini.ai")
    ai.setup({
      n_lines = 500,
      custom_textobjects = {
        -- Function text object
        f = {
          -- Use Treesitter if available, otherwise fall back to pattern matching
          a = function() 
            return ai.gen_spec.treesitter({ a = "@function.outer" }, {}).a() or
                   ai.gen_spec.pair("function", "end", { search_method = "next" }).a()
          end,
          i = function()
            return ai.gen_spec.treesitter({ i = "@function.inner" }, {}).i() or
                   ai.gen_spec.pair("function", "end", { search_method = "next" }).i()
          end,
        },
        -- Class text object
        c = {
          a = function()
            return ai.gen_spec.treesitter({ a = "@class.outer" }, {}).a() or
                   ai.gen_spec.pair("class", "end", { search_method = "next" }).a()
          end,
          i = function()
            return ai.gen_spec.treesitter({ i = "@class.inner" }, {}).i() or
                   ai.gen_spec.pair("class", "end", { search_method = "next" }).i()
          end,
        },
        -- Block, conditional, loop
        o = {
          a = function()
            return ai.gen_spec.treesitter({
              a = { "@block.outer", "@conditional.outer", "@loop.outer" }
            }, {}).a()
          end,
          i = function()
            return ai.gen_spec.treesitter({
              i = { "@block.inner", "@conditional.inner", "@loop.inner" }
            }, {}).i()
          end,
        },
      },
    })

    -- Add which-key integration if which-key is installed
    local has_which_key, which_key = pcall(require, "which-key")
    if has_which_key then
      local i_mappings = {
        [" "] = "Whitespace",
        ['"'] = 'Double quote',
        ["'"] = "Single quote",
        ["`"] = "Backtick",
        ["("] = "Parenthesis",
        [")"] = "Parenthesis",
        [">"] = "Angle bracket",
        ["<"] = "Angle bracket",
        ["]"] = "Square bracket",
        ["["] = "Square bracket",
        ["}"] = "Curly brace",
        ["{"] = "Curly brace",
        ["?"] = "User prompt",
        ["_"] = "Underscore",
        ["a"] = "Argument",
        ["b"] = "Balanced () [] {}",
        ["c"] = "Class",
        ["f"] = "Function",
        ["o"] = "Block, conditional, loop",
        ["q"] = "Quote (' \" `)",
        ["t"] = "Tag",
      }

      local a_mappings = vim.deepcopy(i_mappings)

      which_key.register({
        mode = { "o", "x" },
        i = i_mappings,
        a = a_mappings,
      })
    end
  end,
}