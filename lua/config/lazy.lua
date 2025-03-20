-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- mappings
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>", { desc = "Open Oil file explorer" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Reload configuration
vim.keymap.set("n", "<leader>cr", function()
    -- Source init.lua
    vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
    -- Clear and redraw the screen
    vim.cmd("nohlsearch")
    vim.cmd("redraw")
    -- Notify the user
    vim.notify("Configuration reloaded!", vim.log.levels.INFO)
end, { desc = "Reload Neovim configuration" })

-- Full restart with lazy.nvim
vim.keymap.set("n", "<leader>cR", function()
    -- Sync plugins (update/install/clean)
    vim.cmd("Lazy sync")
    
    -- Clear module cache to force reloading Lua modules
    for name, _ in pairs(package.loaded) do
        if name:match('^plugins%.') or name:match('^config%.') then
            package.loaded[name] = nil
        end
    end
    
    -- Source init.lua
    vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
    
    -- Clear and redraw the screen
    vim.cmd("nohlsearch")
    vim.cmd("redraw")
    
    -- Notify the user
    vim.notify("Full configuration restart completed!", vim.log.levels.INFO)
end, { desc = "Full Neovim configuration restart" })

-- repeat indent in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to lower split" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to upper split" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<leader>wl", "<C-w> <C-q>", { desc = "Close buffer" })

-- options

vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Make sure to setup `mapleader` and `maplocalleader` before

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 8
vim.opt.startofline = false
vim.opt.swapfile = false
vim.opt.backup = false
-- Make sure to setup `mapleader` and `maplocalleader` before
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
vim.opt.colorcolumn = "120"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = {
		enabled = true,
		notify = false,
	},
})
