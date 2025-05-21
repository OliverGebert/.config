-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.

-- global keymap
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tab- und Indentation-Einstellungen
vim.opt.tabstop = 4          -- Tab = 4 Leerzeichen
vim.opt.shiftwidth = 4       -- Automatisches Einrücken = 4 Leerzeichen
vim.opt.expandtab = true     -- Tabs in Leerzeichen umwandeln

-- cursor settings to support blinking - funktioniert gerade nicht aufgrund Probleme zwichen zshrc tmux.conf starship.toml und nvim lua
vim.opt.guicursor = {
  "n-v:block-blinkon1",     -- Normal + Visual: blinkender Block
  "i:ver25-blinkon1",       -- Insert: blinkende vertikale Linie (25 %)
  "r-cr:hor20-blinkon1",    -- Replace + Command Replace: blinkender Unterstrich
  "o:blinkon1",             -- Operator-pending: blinkend, vererbt Block
}

-- other settings
vim.opt.number = true        -- Zeilennummern anzeigen
vim.wo.relativenumber = true -- relative Zeilennummern nutzen
-- vim.keymap.set('n', '<C-e>', vim.cmd.Ex) -- use default for last character in line

-- Mapped key to reload the current Lua file - not in use, has cvonflict with lazy + keymap used for redo
-- vim.api.nvim_set_keymap('n', '<C-r>', ':luafile ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<C-h>', function() -- show all custom keymaps in vsplit window
  vim.cmd("botright split")
  vim.cmd("resize 7")
  vim.cmd("enew")
  local output = vim.fn.systemlist("grepluakeymaps.sh")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, output)   -- paste output
  -- Buffer als "nicht speicherbar" markieren
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.filetype = "lua"   -- treat as .lua file for syntax highlighting
end, { desc = "Show Lua keymaps via grepluakeymaps.sh", noremap = true, silent = true })
vim.keymap.set('n', '<C-y>', ':Lazy<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-g>', 'gqap', { noremap = true, silent = true }) -- wrap current paragraphe
vim.keymap.set('n', '<leader>oh', ':!open  %:r.html<CR>', {})  -- open current filename with html suffix 
vim.keymap.set('n', '<leader>op', ':!open  %:r.pdf<CR>', {})   -- open current filename with pdf suffix
vim.api.nvim_create_user_command("ShowImageKitty", function()
  local img = vim.fn.expand("<cfile>")
  vim.fn.jobstart({ "kitty", "+kitten", "icat", img }, { detach = true })
end, {})
vim.keymap.set('n', '<leader>oi', ":ShowImageKitty<CR>", { desc = "Zeige Bild mit kitty icat" })


vim.opt.termguicolors = true  -- must be set for guisp=red - spell checker

-- keymap for generation and opening of PDF file - works also for files outside current folder with absolut path
vim.keymap.set('n', '<C-p>', function() -- pandoc generates and opens PDF file
  local file = vim.fn.expand('%:p')  -- full path
  local dir = vim.fn.expand('%:p:h')  -- directory only
  local output = vim.fn.expand('%:r') .. '.pdf'  -- substitute suffix
  local cmd = string.format('pandoc "%s" --resource-path="%s" -o "%s"', file, dir, output)
  vim.fn.system(cmd)
  local open_cmd = string.format('open "%s"', output)
  vim.fn.jobstart(open_cmd, { detach = true })
  vim.notify("PDF erzeugt und geöffnet: " .. output, vim.log.levels.INFO)
end, { noremap = true, silent = true })
