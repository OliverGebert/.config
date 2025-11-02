-- ~/.config/nvim/lua/plugins/fugitive.lua
return {
  "tpope/vim-fugitive",
  lazy = false,
  cmd = {
    "G", "Gdiff", "Gvdiffsplit", "Gread", "Gwrite",
    "Glog", "Ggrep", "GMove", "GDelete", "GBrowse"
  },
  config = function()
    local mapk = require("utils").mapk
    mapk('n', '<leader>gs', "<cmd>G<CR>", "Git Status (Fugitive)" )
    mapk('n', '<leader>gd', "<cmd>Gvdiffsplit<CR>", "Git Diff (HEAD vs current)" )
    mapk('n', '<leader>gb', "<cmd>Git blame<CR>", "Git Blame" )
    mapk('n', '<leader>gl', "<cmd>Git log<CR>", "Git Log" )
    mapk('n', '<leader>gc', "<cmd>Git commit -v<CR>", "Git Commit" )
    mapk('n', '<leader>gp', "<cmd>Git push<CR>", "Git Push" )
  end,
}
