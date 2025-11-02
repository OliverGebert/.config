return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    config = function()
        local mapk= require("utils").mapk
        -- Globales Fold-Verhalten
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        require("ufo").setup({
            provider_selector = function(_, filetype)
                if vim.tbl_contains({ "lua", "json", "javascript", "html", "markdown" }, filetype) then
                    return { "treesitter", "indent" }
                elseif vim.tbl_contains({ "python", "tex" }, filetype) then
                    return { "indent", "treesitter" } -- Treesitter fallback, falls nötig
                else
                    return { "treesitter", "indent" } -- default fallback
                end
            end,
        })
        -- zO/zC: Alle Folds auf aktueller Ebene öffnen/schließen
        mapk('n', 'zC', function() --, close folds on current level
            local lnum = vim.fn.line(".")
            local level = vim.fn.foldlevel(lnum)
            if level > 0 then
                require("ufo").closeFoldsWith(level)
            else
                print("no folds on this level")
            end
        end, "Close folds at cursor level" )
        mapk('n', 'zO', function() require("ufo").openAllFolds() end, "Open all folds" )
    end,
}
