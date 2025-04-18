
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.

-- global keymap
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tab- und Indentation-Einstellungen
vim.opt.tabstop = 4          -- Tab = 4 Leerzeichen
vim.opt.shiftwidth = 4       -- Automatisches Einrücken = 4 Leerzeichen
vim.opt.expandtab = true     -- Tabs in Leerzeichen umwandeln

-- other settings
vim.opt.number = true        -- Zeilennummern anzeigen
vim.wo.relativenumber = true -- relative Zeilennummern nutzen
vim.keymap.set('n', '<C-e>', vim.cmd.Ex) -- exit nvim

vim.api.nvim_set_keymap('n', '<C-r>', ':!open  %:r.html<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>pg', ':!pandoc % -o %:r.pdf<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pv', ':!open %:r.pdf<CR>', { noremap = true, silent = true })
