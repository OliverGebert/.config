return {
    "nvimtools/none-ls.nvim",
    config = function()
        local mapk = require("utils").mapk
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua, -- lua
                null_ls.builtins.formatting.prettier, -- JS
                null_ls.builtins.formatting.isort, -- python
                --                null_ls.builtins.formatting.black, -- python
                null_ls.builtins.completion.spell,
            },
        })
        mapk('n', '<leader>lf', vim.lsp.buf.format, "format text according to LSP rules" )
        mapk('x', '<leader>lf', vim.lsp.buf.format, "format text according to LSP rules" )
    end,
}
