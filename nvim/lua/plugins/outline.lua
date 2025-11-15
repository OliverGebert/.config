return {
  "hedyhli/outline.nvim",
  config = function()
    local mapk = require("utils").mapk
    mapk('n', '<C-o>', '<cmd>Outline<CR>', "Toggle: Outline" )
    require("outline").setup {}
  end,
}
