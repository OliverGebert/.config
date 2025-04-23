return {"nvim-neo-tree/neo-tree.nvim",
	opts = {
		filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = true,
--			hide_by_name = {
--		  		".github",
--		  		".gitignore",
--		  		"package-lock.json",
--			},
--			never_show = { ".git" },
			},
		},
    },
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set('n', '<leader>nf', ':Neotree filesystem reveal left focus <CR>')
		vim.keymap.set('n', '<leader>nb', ':Neotree buffers left focus <CR>')
		vim.keymap.set('n', '<leader>nc', ':Neotree close<CR>')
	end
}

