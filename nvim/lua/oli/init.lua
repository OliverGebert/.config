require("oli.lazy")
print("*** >oli.init")


-- other settings
vim.wo.relativenumber = true
vim.keymap.set('n', '<C-e>', vim.cmd.Ex)
--vim.keymap.set('n', '<C-y>', vim.cmd("lua vim.ui.open(vim.fn.expand('%'))"))
