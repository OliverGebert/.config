return	{'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set('n', '<C-f>', builtin.find_files, {})
			-- live_grep requires ripgrep -> 'brew install ripgrep' does the trick
			vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
			-- vim.keymap.set('n', '<C-c>', builtin.open, {})
		end
	}

-- setup telescope: reduce preview_cutoff to allow preview window on smaller panes
