return {
  "mikavilpas/yazi.nvim",
  opts = {
    floating_window_scaling_factor = 0.8,
    -- Funktion, die aufgerufen wird, wenn eine Datei ausgewählt wird
    on_select = function(file_path)
      -- Datei im aktuellen Fenster öffnen
      vim.cmd("edit " .. vim.fn.fnameescape(file_path))
    end,
  },
  init = function()
    -- Keymap zum Öffnen des Browsers
    local mapk = require("utils").mapk
    mapk('n', '<leader>oy', function() vim.cmd("Yazi") end, "Open Yazi File Browser" )
  end,
}
