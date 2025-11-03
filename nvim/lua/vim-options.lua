-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tab- und Indentation-Einstellungen
vim.opt.tabstop = 4          -- Tab = 4 Leerzeichen
vim.opt.shiftwidth = 4       -- Automatisches Einrücken = 4 Leerzeichen
vim.opt.expandtab = true     -- Tabs in Leerzeichen umwandeln

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
local mapk = require("utils").mapk
mapk('n', '<C-l>', ':Lazy<cr>', "open Lazy")
mapk('n', '<C-g>', 'gqap', "wrap current paragraphe")
mapk("n", "<leader>oh", ":!open  %:r.html<CR>", "Open file with html suffix")
mapk('n', '<leader>op', ':!open  %:r.pdf<CR>', "Open file with pdf suffix")

-- Swagger UI für die aktuelle .yaml-Datei starten
mapk('n', '<leader>os', function() --, Open swagger (yaml) file in browser
    local file = vim.api.nvim_buf_get_name(0) -- aktuelle Datei
    if file == "" then
        print("Keine Datei geöffnet!")
        return
    end
    if not file:match("%rya?ml$") then
        print("Keine YAML-Datei!")
        return
    end
    local port = "8066"
    vim.fn.jobstart({"npx", "swagger-ui-watcher", file, "--port", port}, {detach = true})
    print("Swagger UI gestartet für " .. file .. " auf http://localhost:" .. port)
end, "Open Swagger UI for current YAML file" )

-- deleting non latex unicode characters out of visual block to allow PDF generation
mapk('n', '<leader>xu', function() --, Vimtex: delete non latex unicode characters
  vim.cmd("echo 'ctrl-x pressed'")
  vim.cmd("s/[^A-Za-z0-9 äöüÄÖÜß.,\\-_\"'()\\[\\]{}:;\\/\\\\?!@#%&§^$=+*<>`|]//gc")
end, "Clean non-LaTeX-safe chars" )

-- generating help information based on http://cht.sh
mapk('n', '<leader>oc', function() --, Open cheat sheet with word under cursor
  local lang = vim.bo.filetype or ""
  if lang == "" then
    vim.notify("No filetype detected", vim.log.levels.WARN)
    return
  end
  vim.notify("Filetype detected: " .. lang)

  local word = vim.fn.expand("<cword>")
  if not word or word == "" then
    vim.notify("No word under cursor", vim.log.levels.WARN)
    return
  end
  vim.notify("Word under Cursor: " .. word)

  -- Create a scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Open floating window
  local width = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.6)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    border = "rounded",
    style = "minimal",
  })
  -- Run the terminal inside the buffer
  vim.fn.termopen(string.format("curlie -s 'http://cht.sh/%s/%s'", lang, word))

  -- Keybindings für schnelles Schließen
  vim.keymap.set('t', '<Esc>', [[<C-\><C-n>:close<CR>]], { buffer = buf, nowait = true })
  vim.keymap.set('t', 'q', [[<C-\><C-n>:close<CR>]], { buffer = buf, nowait = true })
  vim.keymap.set('n', 'q', ':close<CR>', { buffer = buf, nowait = true })
end, "open word under cursor in http://cht.sh")

mapk('n', '<C-h>', function()    --, Open help for custom key maps
  -- Erstelle einen neuen Buffer für das Terminal
  local buf = vim.api.nvim_create_buf(false, true)  -- nofile, scratch buffer

  -- Floating Window Parameter
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.6)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    border = "rounded",
    style = "minimal",
    focusable = true,
  })

  -- Terminal starten und Script ausführen
  vim.fn.termopen({ "grepluakeymaps.sh" })

  -- Keybindings für schnelles Schließen
  vim.keymap.set('t', '<Esc>', [[<C-\><C-n>:close<CR>]], { buffer = buf, nowait = true })
  vim.keymap.set('t', 'q', [[<C-\><C-n>:close<CR>]], { buffer = buf, nowait = true })
  vim.keymap.set('n', 'q', ':close<CR>', { buffer = buf, nowait = true })
end, "open help for keymappings")

-- keymap for generation and opening of PDF file - works also for files outside current folder with absolut path
mapk('n', '<C-p>', function() --, Pandoc: generate and open PDF file
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
end, "generater and open pdf file")
