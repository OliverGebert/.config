return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { 
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-bibtex.nvim", -- bibtex extension
            "nvim-telescope/telescope-live-grep-args.nvim", -- extension required for grep of \todo, to avoid escape conflict
        },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "find file fuzzy with picker"})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Find expression with grep in folder"}) -- live_grep requires ripgrep 
            vim.keymap.set('n', '<leader>fm', ':Telescope marks<CR>', { noremap = true, silent = true, desc = "find mark with Picker" })
            vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { desc = "Find buffer with picker"})
            vim.keymap.set('n', '<leader>fc', ":Telescope bibtex<CR>", { desc = "Find BibTeX Citation with Picker" })
            local lga = require("telescope").extensions.live_grep_args
            vim.keymap.set('n', '<leader>ft', function() -- find todo{} in latex
                lga.live_grep_args({
                    default_text = "\\todo",
                    additional_args = function()
                        return {"--fixed-strings"}
                    end,
                })
            end, { desc = "Find \todo comments in latex files" })

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
            require("telescope").load_extension("live_grep_args")
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
