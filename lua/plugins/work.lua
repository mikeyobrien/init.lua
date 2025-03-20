-- Only load work plugins if WORK env variable is set to true
local function should_load_work_plugins()
    local work_env = os.getenv("WORK")
    return work_env == "true"
end

-- Return empty table if work plugins shouldn't be loaded
if not should_load_work_plugins() then
    return {}
end

return {
	{
		"nvim-java/nvim-java",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		ft = { "java" },
		config = function()
			local home = os.getenv("HOME")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local root_markers = { ".bemol" }

			-- Helper function for bemol workspace folders
			local function bemol_setup(client, bufnr)
				local function contains(table, value)
					for _, table_value in ipairs(table) do
						if table_value == value then
							return true
						end
					end
					return false
				end

				local bemol_dir = vim.fs.find({ ".bemol" }, { upward = true, type = "directory" })[1]
				local ws_folders_lsp = {}
				if bemol_dir then
					local file = io.open(bemol_dir .. "/ws_root_folders", "r")
					if file then
						for line in file:lines() do
							table.insert(ws_folders_lsp, line)
						end
						file:close()
					end

					for _, line in ipairs(ws_folders_lsp) do
						if not contains(vim.lsp.buf.list_workspace_folders(), line) then
							vim.lsp.buf.add_workspace_folder(line)
						end
					end
				end
			end

			-- Set up Java LSP keybindings
			local function setup_keymaps(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<leader>jo", function()
					require("jdtls").organize_imports()
				end, opts)
				vim.keymap.set("n", "<leader>jt", function()
					require("java.test").run()
				end, opts)
				vim.keymap.set("n", "<leader>tt", "<cmd>:lua require('java').test.run_current_method()<CR>", opts)
				vim.keymap.set("n", "<leader>tT", "<cmd>:lua require('java').test.run_current_classs()<CR>", opts)
				vim.keymap.set("n", "<leader>td", "<cmd>:lua require('java').test.debug_current_method()<CR>", opts)
				vim.keymap.set("n", "<leader>ts", "<cmd>:lua require('java').test.view_last_report()<CR>", opts)
				vim.keymap.set("n", "<leader>tp", "<cmd>:lua require('java').profile.ui()<CR>", opts)
				vim.keymap.set("n", "<leader>co", function()
					vim.lsp.buf.code_action({
						--@diagnostic disable-next-line: missing-fields
						context = { only = { "source.organizeImports" } },
						apply = true,
					})
				end)
			end

			require("java").setup({
                spring_boot_tools = {
                    enable = false,
                },
				-- Enable auto installation of JDK
				jdk = {
					auto_install = true,
				},
				-- Configure the Java LSP
				jdtls = {
					settings = {
						java = {
							references = {
								includeDecompiledSources = true,
							},
							eclipse = {
								downloadSources = true,
							},
							maven = {
								downloadSources = true,
							},
							implementationsCodeLens = {
								enabled = true,
							},
							referencesCodeLens = {
								enabled = true,
							},
							format = {
								enabled = false,
							},
							sources = {
								organizeImports = {
									starThreshold = 9999,
									staticStarThreshold = 9999,
								},
							},
							signatureHelp = {
								enabled = true,
							},
							completion = {
								favoriteStaticMembers = {
									"org.hamcrest.MatcherAssert.assertThat",
									"org.hamcrest.Matchers.*",
									"org.hamcrest.CoreMatchers.*",
									"org.junit.jupiter.api.Assertions.*",
									"java.util.Objects.requireNonNull",
									"java.util.Objects.requireNonNullElse",
									"org.mockito.Mockito.*",
								},
								filteredTypes = {
									"com.sun.*",
									"io.micrometer.shaded.*",
									"java.awt.*",
									"jdk.*",
									"sun.*",
								},
							},
						},
					},
				},
				-- Configure root directory detection
				root_dir = function()
					return require("java.utils").find_root(root_markers)
				end,
				-- Configure the data directory for workspaces
				data_dir = function()
					local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
					return home .. "/.cache/jdtls/workspace/" .. project_name
				end,
				-- Enable Java DAP
				dap = {
					hotcodereplace = "auto",
				},
				-- Enable Java test
				test = {
					enabled = true,
				},
			})

			require("lspconfig").jdtls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					-- Run bemol function to add workspace folders
					bemol_setup(client, bufnr)
					setup_keymaps(client, bufnr)
				end,
			})
		end,
	},
	{
		name = "amazonq",
		url = "ssh://git.amazon.com/pkg/AmazonQNVim",
		config = function()
			local q = require("amazonq")
			require("amazonq").setup({
				ssoStartUrl = "https://amzn.awsapps.com/start",
				filetypes = {
					"amazonq",
					"bash",
					"java",
					"python",
					"typescript",
					"javascriptreact",
					"lua",
					"sh",
					"ruby",
					"javascript",
					"go",
					"rust",
					"lua",
				},
			})
			vim.keymap.set("n", "<leader>qq", ":AmazonQ toggle<CR>", { desc = "Toggle QChat" })
			vim.keymap.set("n", "<leader>qQ", ":AmazonQ clear<CR>", { desc = "Toggle QChat" })
			vim.keymap.set("v", "<leader>qe", ":AmazonQ explain<CR>", { desc = "Explain code" })
			vim.keymap.set("v", "<leader>qf", ":AmazonQ fix<CR>", { desc = "Fix code" })
			vim.keymap.set("v", "<leader>qr", ":AmazonQ refactor<CR>", { desc = "Refactor code" })
			vim.keymap.set("n", "<leader>q?", ":AmazonQ help<CR>", { desc = "Q help" })
		end,
	},
}

