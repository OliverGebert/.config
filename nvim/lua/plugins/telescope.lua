return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-bibtex.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-f>", builtin.find_files, {})
            -- live_grep requires ripgrep -> 'brew install ripgrep' does the trick
            vim.keymap.set("n", "<C-g>", builtin.live_grep, {})
            vim.keymap.set("n", "<C-m>", ':Telescope marks<CR>', { noremap = true, silent = true })
            vim.keymap.set("n", "<C-b>", ':Telescope buffers<CR>', {})
            vim.keymap.set("n", "<leader>cb", ":Telescope bibtex<CR>", { desc = "BibTeX Citation Picker" })
            vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "Find References" })
            vim.keymap.set("n", "<leader>cd", require("telescope.builtin").lsp_definitions, { desc = "Find Definitions" })
            require("telescope").setup({
                extensions = {
                    bibtex = {
                        depth = 1,
                        format = "plain", -- oder "custom"
                        global_files = { "~/home/leadership/Literatur.bib" }, -- Passe das an deinen Pfad an
                    },
                },
                defaults = {
                    layout_config = {
                        horizontal = {
                            preview_cutoff = 10,
                        },
                    },
                },
            })
        require("telescope").load_extension("bibtex")
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}

-- setup telescope: reduce preview_cutoff to allow preview window on smaller panes
