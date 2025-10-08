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
vim.opt.termguicolors = true  -- must be set for guisp=red - spell checker

-- custom keymaps
vim.keymap.set('n', '<C-l>', ':Lazy<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-g>', 'gqap', { noremap = true, silent = true }) -- wrap current paragraphe
vim.keymap.set('x', '<C-g>', 'gq', { noremap = true, silent = true, desc = "Umbruch Auswahl" })
vim.keymap.set('n', '<leader>oh', ':!open  %:r.html<CR>', {})  -- open current filename with html suffix 
vim.keymap.set('n', '<leader>op', ':!open  %:r.pdf<CR>', {})   -- open current filename with pdf suffix

-- Swagger UI für die aktuelle .yaml-Datei starten
vim.keymap.set('n', '<leader>os', function() -- open yaml file as swagger file in browser
    local file = vim.api.nvim_buf_get_name(0) -- aktuelle Datei
    if file == "" then
        print("Keine Datei geöffnet!")
        return
    end
    if not file:match("%.ya?ml$") then
        print("Keine YAML-Datei!")
        return
    end

    local port = "8066"
    vim.fn.jobstart({"npx", "swagger-ui-watcher", file, "--port", port}, {detach = true})
    print("Swagger UI gestartet für " .. file .. " auf http://localhost:" .. port)
end, { desc = "Open Swagger UI for current YAML file" })

-- keymap for deleting non latex unicode characters out of visual block to allow PDF generation
vim.keymap.set('v', '<C-x>', function()  -- delete non latex unicode characters
  vim.cmd([[%s/[^A-Za-z0-9 äöüÄÖÜß.,\-_"'()\[\]{}:;\/\\?!@#%&§^$=+*<>`|]//gc]])
end, { desc = "Clean non-LaTeX-safe chars" })

-- keymap for generating help information based on grepluakeymaps
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

-- keymap for generation and opening of PDF file - works also for files outside current folder with absolut path
vim.keymap.set('n', '<C-p>', function() -- pandoc generates and opens PDF file
  local file = vim.fn.expand('%:p')  -- full path
  local dir = vim.fn.expand('%:p:h')  -- directory only
  local output = vim.fn.expand('%:r') .. '.pdf'  -- substitute suffix
  local cmd = string.format('pandoc "%s" --resource-path="%s" -o "%s" --number-sections', file, dir, output)
  local result = vim.fn.systemlist(cmd)
  local exit_code = vim.v.shell_error

  if exit_code == 0 then
    local open_cmd = string.format('open "%s"', output)
    vim.fn.jobstart(open_cmd, { detach = true })
    vim.notify("PDF erzeugt und geöffnet: " .. output, vim.log.levels.INFO)
  else
    vim.notify("Pandoc Fehler:\n" .. table.concat(result, "\n"), vim.log.levels.ERROR)
  end
end, { noremap = true, silent = true })

-- keymap and function for showing images with kitty in nvim terminal - not working as nvim does not allow image information to be tranferred
-- vim.api.nvim_create_user_command("ShowImageKitty", function()
--   local img = vim.fn.expand("<cfile>")
--   vim.fn.jobstart({ "kitty", "+kitten", "icat", img }, { detach = true })
-- end, {})
-- vim.keymap.set('n', '<leader>oi', ":ShowImageKitty<CR>", { desc = "Zeige Bild mit kitty icat" })
