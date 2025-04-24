return  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {},
    config = function()
        --vim.keymap.set("v", "<leader>re", require("refactoring").refactor("Extract Function"), { noremap = true, silent = true, desc = "Extract Function" })
        vim.keymap.set({ "n", "x" }, "<leader>re", function() return require('refactoring').refactor('Extract Function') end, { expr = true })
        vim.keymap.set({ "n", "x" }, "<leader>rf", function() return require('refactoring').refactor('Extract Function To File') end, { expr = true })
        vim.keymap.set({ "n", "x" }, "<leader>ri", function() return require('refactoring').refactor('Inline Function') end, { expr = true })
        -- vim.keymap.set({ "n", "x" }, "<leader>rv", function() return require('refactoring').refactor('Extract Variable') end, { expr = true })
        -- vim.keymap.set({ "n", "x" }, "<leader>ri", function() return require('refactoring').refactor('Inline Variable') end, { expr = true })
        -- vim.keymap.set({ "n", "x" }, "<leader>rbb", function() return require('refactoring').refactor('Extract Block') end, { expr = true })
        -- vim.keymap.set({ "n", "x" }, "<leader>rbf", function() return require('refactoring').refactor('Extract Block To File') end, { expr = true })
        require('refactoring').setup({})
    end,
}
