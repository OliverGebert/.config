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
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "find file fuzzy with picker"})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Find expression with grep in folder"})
            vim.keymap.set('v', '<leader>fg', function() -- grep text in visual
              vim.cmd('normal! "vy')  -- speichert die Selektion in Register v
              local text = vim.fn.getreg("v")
              require('telescope.builtin').live_grep({ default_text = text })
            end, { desc = "Live Grep mit selektiertem Text" })
            vim.keymap.set('n', '<leader>fm', ':Telescope marks<CR>', { desc = "find mark with Picker" })
            vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { desc = "Find buffer with picker"})
            vim.keymap.set('n', '<leader>fc', ":Telescope bibtex<CR>", { desc = "Find BibTeX Citation with Picker" })
            local lga = require("telescope").extensions.live_grep_args
            vim.keymap.set('n', '<leader>fl', function() -- find label{} in latex
                lga.live_grep_args({
                    default_text = "\\label{",
                    additional_args = function()
                        return {"--fixed-strings"}
                    end,
                    attach_mappings = function(prompt_bufnr, map)
                      actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        if selection and selection.text then
                          local label = selection.text:match("\\label{(.-)}")
                          if label then
                            vim.fn.setreg("+", label)   -- in System-Clipboard
                            vim.notify("Label kopiert: " .. label)
                          end
                        end
                      end)
                      return true
                    end,
                })
            end, { desc = "Find label in latex files" })

            vim.keymap.set('n', '<leader>ft', function() -- find todo{} in latex
                lga.live_grep_args({
                    default_text = "\\todo{",
                    additional_args = function()
                        return {"--fixed-strings"}
                    end,
                })
            end, { desc = "Find todo comments in latex files" })

            local function open_with_mac()
                builtin.find_files({
                    hidden = true,
                    no_ignore = true,
                    attach_mappings = function(prompt_bufnr, map)
                        local open_file = function()
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            if selection and selection.path then
                                vim.fn.jobstart({"open", selection.path}, {detach = true})
                            end
                        end
                        map("i", "<CR>", open_file)
                        map("n", "<CR>", open_file)
                        return true
                    end
                })
            end
            vim.keymap.set('n', '<leader>fo', open_with_mac, { desc = "find file and open externally (macOS)" })

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
