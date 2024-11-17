return 	{
        'barrett-ruth/live-server.nvim',
        build = 'pnpm add -g live-server',
        cmd = { 'LiveServerStart', 'LiveServerStop' },
        config = function() 
		vim.keymap.set("n", "<leader>ls", "<esc>:LiveServerStart<cr>")	
	end
	}

