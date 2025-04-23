return {
    {
    "nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
        vim.keymap.set("n", "<leader>ti", ":TSInstallInfo<CR>", {  noremap = true, silent = true, desc = "show installation info" })
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			ensure_installed = { "python", "lua", "javascript", "html", "latex", "markdown" },
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
        vim.keymap.set("n", "<leader>tp", ":TSPlaygroundToggle<CR>", {  noremap = true, silent = true, desc = "toggle left window for playground info" })
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
        vim.keymap.set("n", "<leader>tc", ":TSContextToggle<CR>", {  noremap = true, silent = true, desc = "toggle top line for context info" })
        require("treesitter-context").setup({
            enable = true,        -- Aktiviert Kontextzeile
            max_lines = 3,        -- Begrenze Höhe der Kontextanzeige
            trim_scope = "inner", -- Kontextbereiche zurückschneiden
            mode = "topline",      -- Kontext basiert auf Cursorposition
            separator = nil,      -- Oder z.B. "─" für Linie unterhalb
        })
    end,
    },
    config = function()
        -- Autocommand für Cursorbewegung und Aktualisierung der Context Line
        vim.cmd([[autocmd CursorMoved,CursorMovedI * lua require("treesitter-context").update()]])
    end,
}
