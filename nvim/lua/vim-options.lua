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

-- Mapped key to reload the current Lua file - not in use, has cvonflict with lazy + keymap used for redo
-- vim.api.nvim_set_keymap('n', '<C-r>', ':luafile ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

-- Mappe <Ctrl>g, um den aktuellen Absatz mit gq zu formatieren
vim.api.nvim_set_keymap('n', '<C-g>', 'gqap', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':!open  %:r.html<CR>', {})

vim.opt.termguicolors = true  -- must be set for guisp=red - spell checker
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   callback = function()
--     vim.cmd("highlight SpellBad gui=underline guisp=Red")
--     vim.cmd("highlight SpellCap gui=underline guisp=Orange")
--   end,
-- })

vim.keymap.set('n', '<leader>pg', function()
  -- full path
  local file = vim.fn.expand('%:p')
  -- directory only
  local dir = vim.fn.expand('%:p:h')
  -- substitute suffix
  local output = vim.fn.expand('%:r') .. '.pdf'
  local cmd = string.format('pandoc "%s" --resource-path="%s" -o "%s"', file, dir, output)
  vim.fn.system(cmd)
  local open_cmd = string.format('open "%s"', output)
  vim.fn.jobstart(open_cmd, { detach = true })
  vim.notify("PDF erzeugt und geöffnet: " .. output, vim.log.levels.INFO)
end, { noremap = true, silent = true })
