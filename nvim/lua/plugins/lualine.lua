-- define function for CodeCompanion spinner
local spinner_symbols = {"⠋","⠙","⠹","⠸","⠼","⠴","⠦","⠧","⠇","⠏"}
local spinner_len = #spinner_symbols
local processing = false
local spinner_index = 1

local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "CodeCompanionRequest*",
  group = group,
  callback = function(request)
    if request.match == "CodeCompanionRequestStarted" then
      processing = true
    elseif request.match == "CodeCompanionRequestFinished" then
      processing = false
    end
  end,
})

local function spinner()
  if processing then
    spinner_index = (spinner_index % spinner_len) + 1
    return spinner_symbols[spinner_index]
  end
  return ""
end

-- function to calculate for .py file, where the python interpreter is linked to, e.g. for .venv
function python_host()
  local path = vim.g.python3_host_prog or "python"
  local parts = {}
  for part in string.gmatch(path, "[^/\\]+") do
    table.insert(parts, part)
  end
  local count = 4  -- number of path parts to keep
  local short_path = table.concat(vim.list_slice(parts, #parts - count + 1), "/")
  return "🐍 " .. short_path
end

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
          { 'filename', path = 1 },
          { python_host, cond = function() return vim.bo.filetype == 'python' end },
        },
        lualine_x = {
          { spinner },    -- Show the CodeCompanion spinner
          { function()      -- Anzeige ob Spell aktiv ist
              return vim.wo.spell and "SPELL✓" or ""
            end,
            cond = function() return vim.bo.filetype ~= "" end, -- Optional: nur wenn ein Filetyp geladen ist
            color = { fg = "#A6E3A1", gui = "bold" },            -- Optional: Farbe & Stil
          },
          -- 'encoding',
          -- 'fileformat',
          'filetype',
        },
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
