print("*** >lua.oli.lazy")
-- Bootstrap lazy.nvim -> if not existent load from git
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.

-- global keymap
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- define plugins
local plugins = { 
	{"catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
}
local opts = {}

-- Setup lazy
require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-f>', builtin.find_files, {})
-- live_grep requires ripgrep -> 'brew install ripgrep' does the trick
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
-- vim.keymap.set('n', '<C-c>', builtin.open, {})

-- setup telescope: reduce preview_cutoff to allow preview window on smaller panes
require("telescope").setup({
  defaults = {
    layout_config = {
      horizontal = {
        preview_cutoff = 10,
      },
    },
  },
})

-- setup treesitter for pyton, lua, js and HTML
require("nvim-treesitter.configs").setup({
	ensure_installed = { "python", "lua", "javascript", "html" },
	highlight = { enable = true },
	indent = { enable = true },  
})

-- setup catpuccin
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

-- vim.keymap.set('n', '<C-e>', vim.cmd.Ex)
-- vim.keymap.set('n', '<C-g>', vim.cmd("lua vim.ui.open(vim.fn.expand('%'))"))
