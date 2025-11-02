local M = {}

-- zentrale map()-Funktion fuer keymap passend zur help seite
M.mapk = function(mode, lhs, rhs, desc)
    local opts = { noremap = true, silent = true }
    if desc then
        opts.desc = desc
    end
    vim.keymap.set(mode, lhs, rhs, opts)
end

return M
