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
				ensure_installed = { "lua_ls", "pyright", "ts_ls", "html", "texlab", "volar", "terraformls", "yamlls"},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig", -- ensure LSPs communicate to nvim
        dependencies = {"b0o/SchemaStore.nvim"},
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
            lspconfig.terraformls.setup({
              settings = {
                terraform = {
                  experimentalFeatures = true,
                },
              },
            })
			lspconfig.yamlls.setup({
				settings = {
					yaml = {
						schemas = require("schemastore").yaml.schemas(),
						validate = true,
						completion = true,
						hover = true,
						format = { enable = true },
						schemaStore = {
							enable = false, -- wird durch SchemaStore.nvim übernommen
						},
					},
				},
			})
            -- Keymaps (LSP actions via lspsaga)
            vim.keymap.set('n', '<leader>le', "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Zeige LSP-Diagnostik (Popup)" })
            vim.keymap.set('n', '<leader>lh', "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover-Dokumentation anzeigen" })
            vim.keymap.set('n', '<leader>ra', "<cmd>Lspsaga code_action<CR>", { desc = "Code Action (Popup)" })
            vim.keymap.set('n', '<leader>rn', "<cmd>Lspsaga rename<CR>", { desc = "Symbol umbenennen (Popup)" })
            vim.keymap.set('n', '<leader>fr', "<cmd>Lspsaga finder<CR>", { desc = "Finde Referenzen/Definitionen (Popup)" })
            vim.keymap.set('n', '<leader>fd', function()  -- find lsp definition
                require("telescope.builtin").lsp_definitions({
                    jump_type = "never"
                })
            end, { desc = "Picker for Definitions" })
		end,
	},
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach", -- lazy load when LSP attaches to buffer
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false, -- z.B. Navigation im Fenstertitel deaktivieren
        },
        ui = {
          border = "rounded",
        },
      })
    end,
  },
}
