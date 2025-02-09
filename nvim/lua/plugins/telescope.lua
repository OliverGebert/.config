return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-f>", builtin.find_files, {})
            -- live_grep requires ripgrep -> 'brew install ripgrep' does the trick
            vim.keymap.set("n", "<C-g>", builtin.live_grep, {})
            vim.keymap.set("n", "<C-m>", ':Telescope marks<CR>', { noremap = true, silent = true })
            vim.keymap.set("n", "<C-b>", ':Telescope buffers<CR>', {})
            vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "Find References" })
            vim.keymap.set("n", "<leader>cd", require("telescope.builtin").lsp_definitions, { desc = "Find Definitions" })
            require("telescope").setup({
                defaults = {
                    layout_config = {
                        horizontal = {
                            preview_cutoff = 10,
                        },
                    },
                },
            })
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
