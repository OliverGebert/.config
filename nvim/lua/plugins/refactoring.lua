return  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {},
    config = function()
        vim.api.nvim_create_user_command("GenerateClassDiagram", function()
          -- local path = vim.fn.expand("%:p:h") -- % file :p absolute path :h reduce to path, no file name
          local file = vim.fn.expand("%:t:r") -- % file :t only filename :r reduce to name woithout extension
          local fileext = vim.fn.expand("%:t") -- % file :t only file name with extension
          local dir = vim.fn.expand("%:p:h")       -- directory of the current file
          -- build shell command to: cd into dir && run pyreverse && open result
          local cmd = string.format("cd %s && pyreverse -A -S -m y -o png -p %s %s && open classes_%s.png", dir, file, fileext, file)
          vim.cmd("!" .. cmd)          
          vim.cmd("!open classes_" .. file .. ".png")  -- macOS | ändere für dein OS
        end, {})

        -- Keymaps
        vim.keymap.set('n', '<leader>ru', ":GenerateClassDiagram<CR>", { desc = "Generate Python UML Diagram of current python file" })
        vim.keymap.set({'n', 'x'}, '<leader>re', function() return require('refactoring').refactor('Extract Function') end, { expr = true })
        vim.keymap.set({'n', 'x'}, '<leader>rf', function() return require('refactoring').refactor('Extract Function To File') end, { expr = true })
        vim.keymap.set({'n', 'x'}, '<leader>ri', function() return require('refactoring').refactor('Inline Function') end, { expr = true })
        -- vim.keymap.set({ 'n', 'x' }, '<leader>rv', function() return require('refactoring').refactor('Extract Variable') end, { expr = true })
        -- vim.keymap.set({ 'n', 'x' }, '<leader>ri', function() return require('refactoring').refactor('Inline Variable') end, { expr = true })
        -- vim.keymap.set({ 'n', 'x' }, '<leader>rbb', function() return require('refactoring').refactor('Extract Block') end, { expr = true })
        -- vim.keymap.set({ 'n', 'x' }, '<leader>rbf', function() return require('refactoring').refactor('Extract Block To File') end, { expr = true })
        require('refactoring').setup({})
    end,
}
