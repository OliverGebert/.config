return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    modes = { search = { enabled = true } },
  },
  init = function()
    -- Initialisierung für Lualine
    vim.g.flash_enabled = true

    -- Keymaps sofort verfügbar
    vim.keymap.set('n', 's', function() require('flash').jump() end, { desc = 'Flash jump' })
    vim.keymap.set('x', 's', function() require('flash').jump() end, { desc = 'Flash jump' })
    vim.keymap.set('o', 's', function() require('flash').jump() end, { desc = 'Flash jump' })
    vim.keymap.set('n', 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
    vim.keymap.set('x', 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
    vim.keymap.set('o', 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
    vim.keymap.set('o', 'r', function() require('flash').remote() end, { desc = 'Flash Remote' })
    vim.keymap.set('o', 'R', function() require('flash').treesitter_search() end, { desc = 'Flash Treesitter Search' })
    vim.keymap.set('x', 'R', function() require('flash').treesitter_search() end, { desc = 'Flash Treesitter Search' })

    vim.keymap.set('n', '<C-f>', function() -- toggle flash
      require('flash').toggle()
      vim.g.flash_enabled = not vim.g.flash_enabled
      pcall(function() require('lualine').refresh() end)
    end, { desc = 'Toggle Flash Search' })

    vim.keymap.set('c', '<C-f>', function() -- toggle flash
      require('flash').toggle()
      vim.g.flash_enabled = not vim.g.flash_enabled
      pcall(function() require('lualine').refresh() end)
    end, { desc = 'Toggle Flash Search' })
  end,
}
