return {"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- setup treesitter for pyton, lua, js and HTML
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			-- ensure_installed = { "python", "lua", "javascript", "html" },
			highlight = { enable = true },
			indent = { enable = true },  
		})
	end
}

