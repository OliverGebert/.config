return {
    {

        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false, -- wichtig: KEIN lazy loading
        -- cmd = { "TSInfo", "TSInstall", "TSUpdate", "TSBufEnable", "TSBufDisable" },
        config = function()
            vim.keymap.set('n', '<leader>ti', ":TSInstallInfo<CR>", {desc = "show installation info" })
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                ensure_installed = { 'json', 'python', 'lua', 'typescript', 'tsx', 'vue', 'javascript', 'html', 'latex', 'markdown', 'markdown_inline' },
                highlight = { enable = true },
                indent = { enable = true },
            })
            vim.cmd([[highlight TreesitterContext guibg=#2e3440 guifg=#ffffff]])
        end,
    },
    {
    "nvim-treesitter/playground",
    lazy = false, -- lade direkt, wenn Neovim startet
    cmd = {
        "TSPlaygroundToggle",
        "TSHighlightCapturesUnderCursor",
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        vim.keymap.set('n', '<leader>tp', ":TSPlaygroundToggle<CR>", {desc = "toggle left window for playground info" })
        require("nvim-treesitter.configs").setup({
            playground = {
            enable = true,
            updatetime = 25,
            persist_queries = false,
            },
        })
    end,
    },
    {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false, -- lade direkt, wenn Neovim startet
    config = function()
        vim.keymap.set('n', '<leader>tc', ":TSContextToggle<CR>", {desc = "toggle top line context" })
        require("treesitter-context").setup({
            enable = true,        -- Aktiviert Kontextzeile
            max_lines = 3,        -- Begrenze Höhe der Kontextanzeige
            trim_scope = 'inner', -- Kontextbereiche zurückschneiden
            mode = 'topline',      -- Kontext basiert auf Cursorposition
            separator = nil,      -- Oder z.B. "─" für Linie unterhalb
        })
    end,
    },
    config = function()
        -- Autocommand für Cursorbewegung und Aktualisierung der Context Line
        vim.cmd([[autocmd CursorMoved,CursorMovedI * lua require("treesitter-context").update()]])
    end,
}
