return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    -- globale Optionen für toggleterm
    size = 20,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = "bin/zsh",
    float_opts = {
      border = "curved",
      winblend = 3,
    },
  },

  config = function(_, opts)
    require("toggleterm").setup(opts)
    local Terminal = require("toggleterm.terminal").Terminal

    -- fetch make file, ick target and open in toggletermn
    vim.keymap.set("n", "<C-m>", function()
      local makefile_path = vim.fs.find("Makefile", {
        upward = true,
        path = vim.api.nvim_buf_get_name(0),
      })[1]
      if not makefile_path then
        vim.notify("Kein Makefile gefunden.", vim.log.levels.WARN)
        return
      end
      local make_dir = vim.fs.dirname(makefile_path)

      -- 🔍 Lese Makefile und extrahiere Targets aus .PHONY
      local lines = vim.fn.readfile(makefile_path)
      local targets = {}
      for _, line in ipairs(lines) do
        local phony = line:match("^%.PHONY:%s*(.+)")
        if phony then
          for target in phony:gmatch("%S+") do
            table.insert(targets, target)
          end
          break
        end
      end
      if vim.tbl_isempty(targets) then
        vim.notify("Keine .PHONY Targets gefunden.", vim.log.levels.INFO)
        return
      end

      -- 📜 Telescope Picker anzeigen
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local conf = require("telescope.config").values

      pickers.new({}, {
        prompt_title = "Make Target auswählen",
        finder = finders.new_table {
          results = targets,
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local target = selection[1]

            -- 🛠 Terminal für make <target> öffnen
            local make_term = Terminal:new({
              cmd = "make " .. target,
              dir = make_dir,
              hidden = true,
              direction = "horizontal",
              close_on_exit = false,
              shell = "bin/zsh",
              on_open = function(term)
                vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<Esc>", [[<C-\><C-n><cmd>close<CR>]], { noremap = true, silent = true })
              end,
            })
            make_term:toggle()
          end)
          return true
        end,
      }):find()
    end, { desc = "📦 Makefile-Ziel wählen und ausführen mit toggleterm" })

    -- LazyGit Terminal
    vim.keymap.set('n', '<C-l>', function()
        local lazygit = Terminal:new({
          cmd = "lazygit",
          hidden = true,
          direction = "float", -- optional: "horizontal", "vertical", "tab"
          float_opts = {
            border = "double",
            width = 100,
            height = 40,
          },
          shell = "bin/zsh",
          on_open = function(term)
            vim.cmd("startinsert!") -- oder term:enter()
          end,
          on_close = function(term)
            vim.cmd("startinsert!") -- zurück in Insert-Modus nach Schließen
          end,
        })
        lazygit:toggle()
    end, { desc = "Toggle LazyGit", noremap = true, silent = true })

    -- open interactive zsh
    vim.keymap.set("n", "<C-z>", function()
      local zsh_float = Terminal:new({
        cmd = "zsh -i",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "curved",
          width = 100,
          height = 30,
        },
        on_open = function(term)
          vim.cmd("startinsert!")  -- direkt in den Insert-Modus wechseln
        end,
        on_close = function(term)
          vim.cmd("stopinsert")    -- zurück in den Normal-Modus
        end,
      })
      zsh_float:toggle()
    end, { desc = "Toggle floating ZSH terminal", noremap = true, silent = true })
  end,
}

