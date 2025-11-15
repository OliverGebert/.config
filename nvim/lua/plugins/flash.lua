return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    modes = { search = { enabled = true } },
  },
  init = function()
    local mapk= require("utils").mapk
    -- Initialisierung für Lualine
    vim.g.flash_enabled = true

    -- Keymaps sofort verfügbar
    mapk('nxo', 's', function() require('flash').jump() end, 'Flash jump')
    mapk('nxo', 'S', function() require('flash').treesitter() end, 'Flash Treesitter' )
    mapk('o', 'r', function() require('flash').remote() end, 'Flash Remote' )
    mapk('xo', 'R', function() require('flash').treesitter_search() end, 'Flash Treesitter Search' )

    mapk('nc', '<C-f>', function() --, Toggle flash
      require('flash').toggle()
      vim.g.flash_enabled = not vim.g.flash_enabled
      pcall(function() require('lualine').refresh() end)
    end, 'Toggle Flash Search' )
  end,
}
