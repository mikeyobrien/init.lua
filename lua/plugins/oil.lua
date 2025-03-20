return {
  "stevearc/oil.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
    "mg979/vim-visual-multi",
    "MunifTanjim/nui.nvim",
    "MagicDuck/grug-far.nvim"
  },
  config = function()
    local oil = require "oil"
    oil.setup {
      -- Oil will take over directory buffers (e.g. `vim .` or `:e .`)
      default_file_explorer = true,
      -- Id is automatically added at the beginning, and name at the end
      -- See :help oil-columns
      columns = {
        "icon",
        "size",
        "mtime",
      },
      -- Buffer-local mappings to use in oil buffers
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = {
          callback = function()
            -- get the current directory
            local prefills = { paths = oil.get_current_dir() }

            local grug_far = require "grug-far"
            -- instance check
            if not grug_far.has_instance "explorer" then
              grug_far.open {
                instanceName = "explorer",
                prefills = prefills,
                staticTitle = "Find and Replace from Explorer",
              }
            else
              grug_far.open_instance "explorer"
              -- updating the prefills without clearing the search and other fields
              grug_far.update_instance_prefills("explorer", prefills, false)
            end
          end,
          desc = "oil: Search in directory",
        },
        ["g."] = "actions.toggle_hidden",
      },
    }
  end,
}
