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
				ensure_installed = { "lua_ls", "pyright", "ts_ls", "html", "texlab", "volar", "terraformls", "yamlls", "ltex-ls"},
			})
            require("mason-lspconfig").setup_handlers({
              function(server_name)
                require("lspconfig")[server_name].setup({})
              end,
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
			lspconfig.html.setup({})
            lspconfig.pyright.setup({
              root_dir = util.root_pattern("pyrightconfig.json", ".git", "pytest.ini"),
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic", -- oder "strict"
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace",
                    extraPaths = { "src" }, -- 💡 relativ zum Root, damit Imports in test.py gefunden werden
                  },
                },
              },
            })
            lspconfig.ltex.setup({
              filetypes = { "tex", "bib", "markdown", "org" },
              settings = {
                ltex = {
                  language = "de-DE",
                  disabledRules = { ["DE:SPELLING"] = true }, -- Rechtschreibung ausschalten
                  additionalRules = {
                    enablePickyRules = true,
                    motherTongue = "de-DE",
                  },
                },
              },
            })

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
		end,
	},
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach", -- lazy load when LSP attaches to buffer
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local mapk = require("utils").mapk
        require("lspsaga").setup({
          symbol_in_winbar = {
            enable = false, -- z.B. Navigation im Fenstertitel deaktivieren
          },
          ui = {
            border = "rounded",
          },
        })
        -- Keymaps (LSP actions via lspsaga)
        mapk('n', '<leader>le', "<cmd>Lspsaga show_line_diagnostics<CR>", "Zeige LSP-Diagnostik (Popup)" )
        mapk('n', '<leader>lh', "<cmd>Lspsaga hover_doc<CR>", "Hover-Dokumentation anzeigen" )
        mapk('n', '<leader>ra', "<cmd>Lspsaga code_action<CR>", "Code Action (Popup)" )
        mapk('n', '<leader>rn', "<cmd>Lspsaga rename<CR>", "Symbol umbenennen (Popup)" )
        mapk('n', '<leader>lr', "<cmd>Lspsaga finder<CR>", "Finde Referenzen (Popup)" )
        mapk('n', '<leader>ld', function()  --, find lsp definition
            require("telescope.builtin").lsp_definitions({
                jump_type = "never"
            })
        end, "Picker for Definitions" )
    end,
  },
}
