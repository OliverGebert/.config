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
            local mapk = require("utils").mapk
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            mapk('n', '<leader>fk', builtin.keymaps, "Find: keymap with picker")
            mapk('v', '<leader>fg', function() --, Find: grep visual text
              vim.cmd('normal! "vy')          -- speichert die Selektion in Register v
              local text = vim.fn.getreg("v")
              require('telescope.builtin').live_grep({ default_text = text })
            end, "Live Grep mit selektiertem Text" )
            mapk('n', '<leader>fm', ':Telescope marks<CR>', "Find: mark with Picker" )
            mapk('n', '<leader>fb', ':Telescope buffers<CR>', "Find: buffer with picker")
            mapk('n', '<leader>fc', ":Telescope bibtex<CR>", "Find: BibTeX Citation with Picker" )
            mapk('n', '<leader>fd', function()    --, Find: LSP diagnostics in picker
              builtin.diagnostics({ bufnr = 0 })
            end, "Find diagnostics in current buffer" )

            local lga = require("telescope").extensions.live_grep_args
            mapk('n', '<leader>fl', function() --, Find: label{} in latex
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
                            vim.api.nvim_put({ label }, "c", false, true)
                          end
                        end
                      end)
                      return true
                    end,
                })
            end, "Find label in latex files" )

            mapk('n', '<leader>ft', function() --, Find: todo{} in latex
                lga.live_grep_args({
                    default_text = "\\todo{",
                    additional_args = function()
                        return {"--fixed-strings"}
                    end,
                })
            end, "Find todo comments in latex files" )

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
            mapk('n', '<leader>fo', open_with_mac, "Find: open file outside vim" )

            local pickers = require("telescope.pickers")
            local finders = require("telescope.finders")
            local conf = require("telescope.config").values
            local function pick_process()
                pickers.new({}, {
                    prompt_title = "Running Processes",
                    finder = finders.new_oneshot_job({"ps", "-ef"}, {}),
                    sorter = conf.generic_sorter({}),
                    attach_mappings = function(prompt_bufnr, map)
                        actions.select_default:replace(function()
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            if selection then
                                -- Spalten sauber splitten, Leerzeichen ignorieren
                                local columns = {}
                                for col in selection[1]:gmatch("%S+") do
                                    table.insert(columns, col)
                                end
                                local pid = columns[2]  -- **zweite Spalte = PID**
                                if pid then
                                    local kill_confirm = vim.fn.input("Kill PID " .. pid .. "? (y/n): ")
                                    if kill_confirm:lower() == "y" then
                                        os.execute("kill -9 " .. pid)
                                        print("PID " .. pid .. " killed")
                                    else
                                        print("PID " .. pid .. " skipped")
                                    end
                                end
                            end
                        end)
                        return true
                    end,
                }):find()
            end
            mapk('n', '<leader>fp', pick_process, "Find: process + optionally kill" )

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
