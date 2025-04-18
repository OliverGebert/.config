return	{"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
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
