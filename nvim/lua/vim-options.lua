
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.

-- global keymap
vim.g.mapleader = " "

-- Tab- und Indentation-Einstellungen
vim.opt.tabstop = 4          -- Tab = 4 Leerzeichen
vim.opt.shiftwidth = 4       -- Automatisches Einrücken = 4 Leerzeichen
vim.opt.expandtab = true     -- Tabs in Leerzeichen umwandeln

-- other settings
vim.opt.number = true        -- Zeilennummern anzeigen
vim.wo.relativenumber = true -- relative Zeilennummern nutzen
vim.keymap.set('n', '<C-e>', vim.cmd.Ex) -- exit nvim
-- vim.keymap.set('n', '<C-y>', vim.cmd("lua vim.ui.open(vim.fn.expand('%'))"))
