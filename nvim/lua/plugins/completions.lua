return {
  -- Autocompletion Framework
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP-Vervollständigung
      "hrsh7th/cmp-buffer",    -- Vorschläge aus dem aktuellen Buffer
      "hrsh7th/cmp-path",      -- Vorschläge für Dateipfade
      "saadparwaiz1/cmp_luasnip",  -- Snippet-Unterstützung
      "L3MON4D3/LuaSnip",          -- Snippet-Engine
      "rafamadriz/friendly-snippets"
    },
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<Tab>"] = cmp.mapping.select_next_item(), -- Tab für nächste Vervollständigung
          ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Shift+Tab für vorherige
          -- ['<SPACE>'] = cmp.mapping.complete(),

          ["<S-CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if entry and entry.completion_item and (entry.completion_item.kind == 3 or entry.completion_item.kind == 2) then
                cmp.confirm({ select = true })
                vim.api.nvim_feedkeys("()", "n", true)
                -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", true) -- Cursor links setzen
              else
                cmp.confirm({ select = true })
              end
            else
              fallback()
            end
          end),

          ['<Esc>'] = cmp.mapping.abort(),
  --      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --      ['<C-f>'] = cmp.mapping.scroll_docs(4),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = 'buffer' },
          { name = "path" },
        })
      })
    end,
  },

  -- LSP Support für Python
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").pyright.setup({}) -- Einfacher Python Language Server
    end,
  },
}



