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
vim.opt.splitright = true    -- open vertical split on right side important for codecompanion

-- custom keymaps
vim.keymap.set('n', '<C-h>', function() -- show custom keymaps in floating window
  local buf = vim.api.nvim_create_buf(false, true)
  local lines = vim.fn.systemlist("grepluakeymaps.sh")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].filetype = "lua"
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  -- Key zum Schließen
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', "<cmd>close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', "<cmd>close<CR>", { noremap = true, silent = true })
 -- Floating Window  
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.6),
    row = math.floor(vim.o.lines * 0.2),
    col = math.floor(vim.o.columns * 0.1),
    border = "rounded",
    style = "minimal",
  })
end)
vim.keymap.set('n', '<C-y>', ':Lazy<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-g>', 'gqap', { noremap = true, silent = true }) -- wrap current paragraphe
vim.keymap.set('x', '<C-g>', 'gq', { noremap = true, silent = true, desc = "Umbruch Auswahl" })
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
