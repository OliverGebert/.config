return {
  "hedyhli/outline.nvim",
  config = function()
    local mapk = require("utils").mapk
    mapk('n', '<C-t>', '<cmd>Outline<CR>', "Toggle Outline" )
    require("outline").setup {}
  end,
}
