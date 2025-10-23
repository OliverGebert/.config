
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

-- use env lua file to load central .env file in key value store
require("config.env").load_env_file(vim.fn.stdpath("config") .. "/.env")
require("vim-options")
require("lazy").setup("plugins")

-- Füge ~/.config/nvim dem runtimepath hinzu
vim.opt.runtimepath:append("~/.config/nvim") -- dictionary for vim spell check
-- Setze die Sprache und aktiviere Spellcheck
vim.opt.spelllang = { "de", "en_us" } -- vim spell check langiuages
vim.opt.spell = true -- vim spell check on
vim.g.spell_enabled = true -- lsp check enbaled


-- add functionality to autoread when file changes, e.g because of git pull
vim.o.autoread = true
-- Check for file changes automatically
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, {
  command = "if mode() != 'c' | checktime | endif",
})
-- Show a message when a file is reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File reloaded from disk", vim.log.levels.INFO)
  end,
})

-- add functionality to automatically adjust python interpreter path to local project .venv folder
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
lspconfig.pyright.setup({
  on_init = function(client)
    local path = client.config.root_dir .. '/.venv/bin/python'
    if vim.fn.executable(path) == 1 then
      client.config.settings.python = {
        pythonPath = path
      }
    end
  end,
  root_dir = util.root_pattern('.git', 'pyproject.toml', 'setup.py', 'requirements.txt'),
})
-- autocommand to update python interpreter to .venv folder
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function()
    local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
    if vim.fn.executable(venv_python) == 1 then
      vim.g.python3_host_prog = venv_python
    end
  end,
})
