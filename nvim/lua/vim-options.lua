
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.

-- global keymap
vim.g.mapleader = " "

-- other settings
vim.wo.relativenumber = true
vim.keymap.set('n', '<C-e>', vim.cmd.Ex)
-- vim.keymap.set('n', '<C-y>', vim.cmd("lua vim.ui.open(vim.fn.expand('%'))"))
