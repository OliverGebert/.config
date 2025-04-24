return {
	{
		"williamboman/mason.nvim", -- install mason to manage language servers
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim", -- install language servers
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "ts_ls", "html", "texlab"},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig", -- ensure LSPs communicate to nvim
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.ts_ls.setup({})
			lspconfig.pylsp.setup({})
			lspconfig.html.setup({})
			lspconfig.texlab.setup({
				settings = {
					texlab = {
						build = {
							executable = "latexmk",
							args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
							onSave = true,
						},
						forwardSearch = {
							executable = "zathura", -- oder "skim", "okular", "sumatraPDF"
							args = { "--synctex-forward", "%l:1:%f", "%p" },
						},
					},
				},
			})
            -- keymaps for lsp diagnostics or code action
            vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "Show error/warning message" })
			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "show pop up info to method or type"})
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "shows pop info from LSP actions"})
            -- keymaps for definition and reference picker via telescope
            vim.keymap.set("n", "<leader>fr", require("telescope.builtin").lsp_references, { desc = "Picker for References" })
            vim.keymap.set("n", "<leader>fd", function()
                require("telescope.builtin").lsp_definitions({
                    jump_type = "never"
                })
                end, { desc = "Picker for Definitions" 
            })
            -- keymaps for simple refactoring
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
            -- todo: another refactoring would be extract function, it requires refactoring.nvim
		end,
	},
}
