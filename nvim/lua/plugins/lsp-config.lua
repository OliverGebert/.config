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
				ensure_installed = { "lua_ls", "pylsp", "ts_ls", "html", "texlab"},
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
            -- keymaps
			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, {})
			-- vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
