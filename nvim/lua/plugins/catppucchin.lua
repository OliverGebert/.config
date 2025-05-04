return	{"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
        -- Catppuccin konfigurieren MIT highlight overrides
        require("catppuccin").setup({
          flavour = "mocha", -- oder "latte", "frappe", "macchiato"
          highlight_overrides = {   -- override for latex spell checker highlighting
            mocha = function()
              return {
                SpellBad = { fg = "#f38ba8", underline = true },
                SpellCap = { fg = "#fab387", underline = true },
              }
            end
          }
        })
        vim.cmd.colorscheme "catppuccin-mocha"

        -- Cursorline für das fokussierte Fenster aktivieren
        vim.opt.cursorline = true
        -- Cursorline nur im aktiven Fenster einblenden
        vim.api.nvim_create_autocmd({ "FocusGained", "WinEnter", "BufEnter" }, {
            callback = function()
                vim.wo.cursorline = true
            end,
        })
        vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave", "BufLeave" }, {
            callback = function()
                vim.wo.cursorline = false
            end,
        })
    end
}
