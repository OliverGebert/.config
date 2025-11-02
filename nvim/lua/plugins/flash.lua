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
    mapk('n', 's', function() require('flash').jump() end, 'Flash jump')
    mapk('x', 's', function() require('flash').jump() end, 'Flash jump' )
    mapk('o', 's', function() require('flash').jump() end, 'Flash jump' )
    mapk('n', 'S', function() require('flash').treesitter() end, 'Flash Treesitter' )
    mapk('x', 'S', function() require('flash').treesitter() end, 'Flash Treesitter' )
    mapk('o', 'S', function() require('flash').treesitter() end, 'Flash Treesitter' )
    mapk('o', 'r', function() require('flash').remote() end, 'Flash Remote' )
    mapk('o', 'R', function() require('flash').treesitter_search() end, 'Flash Treesitter Search' )
    mapk('x', 'R', function() require('flash').treesitter_search() end, 'Flash Treesitter Search' )

    mapk('n', '<C-f>', function() --, toggle flash
      require('flash').toggle()
      vim.g.flash_enabled = not vim.g.flash_enabled
      pcall(function() require('lualine').refresh() end)
    end, 'Toggle Flash Search' )

    mapk('c', '<C-f>', function() --, toggle flash
      require('flash').toggle()
      vim.g.flash_enabled = not vim.g.flash_enabled
      pcall(function() require('lualine').refresh() end)
    end, 'Toggle Flash Search' )
  end,
}
