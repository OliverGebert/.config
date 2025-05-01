return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },  -- Für Icons in der Statusline (Dateityp, Git usw.)

  config = function()
    require('lualine').setup({
      options = {
        theme = 'dracula',  -- Wähle dein bevorzugtes Farbtheme (z. B. 'gruvbox', 'tokyonight', 'dracula')
        icons_enabled = true,  -- Aktiviere Icons, sofern verfügbar (über devicons)
        section_separators = { left = '', right = '' },  -- Stylische Pfeile links/rechts um Abschnittsgrenzen zu visualisieren
        component_separators = { left = '', right = '' },  -- Kleine Trennzeichen zwischen Komponenten
        disabled_filetypes = {
          'NvimTree',       -- Verstecke lualine z. B. im Dateibaum
          'neo-tree',
          'TelescopePrompt' -- Auch in Telescope keine Statusline anzeigen
        },
      },

      -- Die Hauptbereiche der Statuszeile
      sections = {
        lualine_a = { 'mode' },  -- Zeigt den aktuellen Modus: NORMAL, INSERT etc.
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        -- 'branch': aktueller Git-Branch
        -- 'diff': Git-Änderungen (added, modified, removed)
        -- 'diagnostics': LSP-Fehler/Warnungen (aus vim.diagnostic)

        lualine_c = {
          { 'filename', path = 1 }
          -- Zeigt Dateinamen + Pfad
          -- path = 0: nur Name, 1: relativ, 2: absolut
        },

        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        -- 'encoding': z. B. utf-8
        -- 'fileformat': z. B. unix (LF), dos (CRLF)
        -- 'filetype': Dateityp wie lua, markdown etc.

        lualine_y = { 'progress' },  -- Zeigt den Fortschritt im File: 10%, 80% etc.
        lualine_z = { 'location' }   -- Zeigt Zeile:Spalte, z. B. 15:42
      },
      extensions = {
        'nvim-tree',   -- Integration: Statusline auch in Dateibaum korrekt
        'quickfix',    -- Zeige Statusline im Quickfix-Fenster
        'fugitive'     -- Git Plugin Integration (tpope/vim-fugitive)
      }
    })
  end
}
