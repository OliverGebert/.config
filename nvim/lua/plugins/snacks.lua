return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- deine bisherigen Module
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },

    -- Terminal-Konfiguration
    terminal = {
      enabled = true,
      -- Standard-Terminalverhalten (gilt für alle Snacks-Terminals)
      position = "bottom",      -- öffnet Terminals unten
      size = 0.25,              -- 25 % der Höhe
      start_insert = true,      -- startet direkt im Insert-Mode
      border = "none",          -- kein Rand für klassisches Look
      close_on_exit = false,    -- Terminal bleibt bestehen
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    -- Keymaps
    vim.keymap.set('n', '<C-q>', function() require("snacks.explorer").open() end, { desc = "Snacks Explorer" })
    vim.keymap.set('n', '<leader>ff', function() require("snacks.picker").files() end, { desc = "Find Files" })
    vim.keymap.set('n', '<leader>fg', function() require("snacks.picker").grep() end, { desc = "Live Grep" })
    vim.keymap.set('n', '<C-z>', function() require("snacks.terminal").toggle() end, { desc = "Toggle Terminal" })
    vim.keymap.set('n', '<leader>od', function() require("snacks.dashboard").open() end, { desc = "Snacks Dashboard" })
  end,
}

