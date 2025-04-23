
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
-- Mapped key to reload the current Lua file
vim.api.nvim_set_keymap('n', '<C-r>', ':luafile ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
-- Mappe <Ctrl>g, um den aktuellen Absatz mit gq zu formatieren
vim.api.nvim_set_keymap('n', '<C-g>', 'gqap', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':!open  %:r.html<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>pg', ':!pandoc % -o %:r.pdf<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pv', ':!open %:r.pdf<CR>', { noremap = true, silent = true })
