-- Erweiterte mapk-Funktion mit automatischer Mode-Erkennung

local M = {}

function M.mapk(mode, lhs, rhs, desc)
  -- Falls mode ein String ist und mehrere Buchstaben enthält (z.B. "nx")
  if type(mode) == "string" and #mode > 1 then
    local modes = {}
    for c in mode:gmatch(".") do
      table.insert(modes, c)
    end
    mode = modes
  end

  -- Fallback, falls nichts angegeben ist
  if mode == nil then
    mode = 'n'
  end

  -- Optionen
  local opts = { noremap = true, silent = true }
  if desc then
    opts.desc = desc
  end

  -- Keymap setzen
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
