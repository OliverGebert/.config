return {"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
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
        window = {
            mappings = {
              ["<CR>"] = "open",        -- Enter öffnet normal
              ["<S-CR>"] = "open_vsplit",     -- vertikaler Split
            },
        },
    },
	config = function()
        vim.keymap.set('n', '<C-q>', ':Neotree filesystem reveal left focus <CR>')
        -- buffer tree does only show active buffers, not all like :ls, therefore keymappings are disabled
		-- vim.keymap.set('n', '<leader>nf', ':Neotree filesystem reveal left focus <CR>')
		-- vim.keymap.set('n', '<leader>nb', ':Neotree buffers left focus <CR>')
        vim.keymap.set('n', '<leader>nc', ':Neotree close <CR>')
	end
}

