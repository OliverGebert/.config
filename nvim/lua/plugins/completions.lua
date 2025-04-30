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
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter akzeptiert Vorschlag
          ["<C-Space>"] = cmp.mapping.complete(), -- Vorschläge manuell aufrufen
          ["<Esc>"] = cmp.mapping.abort(), -- Abbrechen wie gewohnt
        },
        sources = cmp.config.sources({
          { name = 'luasnip' },
          { name = "path" },
          { name = 'nvim_lsp' },
          { name = 'buffer' },
        }),
        sorting = {
          comparators = {
            cmp.config.compare.offset,  -- Priorisiert Vorschläge, die näher an der Cursorposition beginnen
            cmp.config.compare.exact,   -- Gibt exakt passenden Vorschlägen Vorrang
            cmp.config.compare.score,   -- Bewertet anhand von Relevanz (z. B. wie ähnlich der Vorschlag dem Getippten ist)
            cmp.config.compare.kind,    -- Sortiert nach Typ (z. B. Function, Snippet, Variable – basiert auf LSP-Kind- nummern
--            cmp.config.compare.sort_text,   -- Alphabetisch nach sortText, falls vorhanden
--            cmp.config.compare.length,  -- Kürzere Einträge bevorzugt (optional)
--            cmp.config.compare.order,   -- Fallback, falls alles andere gleich ist
          },
        }
      })
    end,
  },

  -- LSP Support für Python
  {
    "neovim/nvim-lspconfig",
    config = function()
        require('lspconfig').pyright.setup{
          settings = {
            python = {
              formatting = { enable = false },  -- Deaktiviert die Formatierung im LSP
            }
          }
        }
    end,
  },
}



