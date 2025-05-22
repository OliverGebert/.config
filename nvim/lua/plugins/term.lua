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
    shell = "/bin/zsh -i -l",
    float_opts = {
      border = "curved",
      winblend = 3,
    },
  },

  config = function(_, opts)
    require("toggleterm").setup(opts)
    local Terminal = require("toggleterm.terminal").Terminal

    -- make file, pick target and open in toggletermn
    vim.keymap.set('n', '<C-m>', function()  -- open picker for targets in near Makefile for execution
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
      local previewers = require("telescope.previewers")
      -- 🔍 Finde alle Targets inkl. zugehöriger Makefile-Blöcke
      local target_infos = {}
      for i, line in ipairs(lines) do
        local target = line:match("^(%w[%w-_%.]+)%s*:")
        if target and vim.tbl_contains(targets, target) then
          local block_lines = { line }
          local j = i + 1
          while j <= #lines and lines[j]:match("^%s*\t") do
            table.insert(block_lines, lines[j])
            j = j + 1
          end
          table.insert(target_infos, {
            target = target,
            block = table.concat(block_lines, "\n"),
          })
        end
      end
      pickers.new({}, {
        prompt_title = "Make Target auswählen",
        finder = finders.new_table {
          results = target_infos,
          entry_maker = function(entry)
            return {
              value = entry.target,
              display = entry.target,
              ordinal = entry.target,
              block = entry.block,
            }
          end,
        },
        sorter = conf.generic_sorter({}),
        previewer = previewers.new_buffer_previewer({
          title = "Makefile Inhalt",
          define_preview = function(self, entry, _)
            local bufnr = self.state.bufnr
            vim.api.nvim_buf_set_option(bufnr, "filetype", "make")
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
            -- Finde die Zeile mit dem gewählten Target
            local target = vim.pesc(entry.value) -- escapen!
            local target_line = nil
            for i, line in ipairs(lines) do
              if line:match("^" .. target .. "%s*:") then
                target_line = i
                break
              end
            end
            -- Setze Cursor und Highlight wenn möglich
            if target_line then
              vim.defer_fn(function()
                if self.state.winid and vim.api.nvim_win_is_valid(self.state.winid) then
                  vim.api.nvim_win_set_cursor(self.state.winid, { target_line, 0 })
                  vim.api.nvim_win_call(self.state.winid, function()
                    vim.cmd("normal! zz")  -- Scrollt Vorschau so, dass Zeile oben ist
                  end)
                  -- Optional: Zeile hervorheben
                  local ns = vim.api.nvim_create_namespace("MakeTargetHighlight")
                  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
                  vim.api.nvim_buf_add_highlight(bufnr, ns, "TelescopePreviewMatch", target_line - 1, 0, -1)
                end
              end, 100)
            end
          end
        }),
        layout_strategy = "horizontal", -- <– MUSS gesetzt sein, sonst wird config ignoriert
        layout_config = {
          width = 0.6,      -- 60% der Bildschirmbreite
          height = 0.6,     -- 50% der Bildschirmhöhe
          preview_width = 0.7,
        },
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local target = selection.value

            local make_term = Terminal:new({
              cmd = "make " .. target,
              dir = make_dir,
              hidden = true,
              direction = "horizontal",
              close_on_exit = false,
              shell = "/bin/zsh -i -l",
              env = { TERM = "xterm-256color"},
              on_open = function(term)
                vim.api.nvim_buf_set_keymap(term.bufnr, 't', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
                vim.api.nvim_buf_set_keymap(term.bufnr, 'n', '<Esc>', [[<C-\><C-n><cmd>close<CR>]], { noremap = true, silent = true })
              end,
            })
            make_term:toggle()
          end)
          return true
        end,
      }):find()
    end, { desc = "📦 Makefile-Ziel wählen und ausführen mit toggleterm" })

    -- LazyGit Terminal
    vim.keymap.set('n', '<C-l>', function()  -- open lazygit in floating window
        local lazygit = Terminal:new({
          cmd = "lazygit",
          hidden = true,
          direction = "float", -- optional: "horizontal", "vertical", "tab"
          float_opts = {
            border = "double",
            width = 120,
            height = 40,
          },
          shell = "/bin/zsh",
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
    vim.keymap.set('n', '<C-z>', function() -- open zsh in floating window
      local zsh_float = Terminal:new({
        cmd = "/bin/zsh -i -l",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "curved",
          width = 120,
          height = 25,
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

