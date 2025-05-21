return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    -- globale Optionen für toggleterm
    size = 20,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 3,
    },
  },

  config = function(_, opts)
    require("toggleterm").setup(opts)
    local Terminal = require("toggleterm.terminal").Terminal

    -- 📦 LazyGit Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float", -- optional: "horizontal", "vertical", "tab"
      float_opts = {
        border = "double",
      },
      on_open = function(term)
        vim.cmd("startinsert!") -- oder term:enter()
      end,
      on_close = function(term)
        vim.cmd("startinsert!") -- zurück in Insert-Modus nach Schließen
      end,
    })

    -- 🎯 Keybinding zum Öffnen von LazyGit
    vim.keymap.set('n', '<C-l>', function()
      lazygit:toggle()
    end, { desc = "Toggle LazyGit", noremap = true, silent = true })

  end,
}

