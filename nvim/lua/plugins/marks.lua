return {
  'chentoast/marks.nvim',  -- Plugin-Name
  event = 'BufReadPost',   -- Lädt das Plugin nur, wenn eine Datei geöffnet wird
  config = function()
    -- Setup von marks.nvim
    require('marks').setup ({
      -- Konfiguriere hier die Optionen
      default_mappings = true,  -- Standard-Tastenkombinationen aktivieren
      signs = true,             -- Marks in der Sign Column anzeigen
      mappings = {},            -- Eigene Mappings, falls benötigt
      -- Weitere Optionen
      builtin_marks = { ".", "<", ">", "^" }, -- Standardmarks, die angezeigt werden
      cyclic = true,            -- Marks in zyklischer Reihenfolge durchgehen
      force_write_shada = true, -- Shada-Datei nicht überschreiben
      refresh_interval = 250,   -- Aktualisierungsintervall in ms
    })
  end
}
