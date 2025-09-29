return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
        search = {
            enabled= true,
        },
    },
  },
  init = function()
    -- initialize the toggle flag for lualine
    vim.g.flash_enabled = true
  end,
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    --{ "<C-f>", mode = { "n" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    --{ "<C-f>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    -- normal mode toggle
    {
      "<C-f>",
      mode = { "n" },
      function()
        require("flash").toggle()
        vim.g.flash_enabled = not vim.g.flash_enabled
        pcall(function() require("lualine").refresh() end)
      end,
      desc = "Toggle Flash Search",
    },
    -- command-line mode toggle
    {
      "<C-f>",
      mode = { "c" },
      function()
        require("flash").toggle()
        vim.g.flash_enabled = not vim.g.flash_enabled
        pcall(function() require("lualine").refresh() end)
      end,
      desc = "Toggle Flash Search",
    },
  },
}

