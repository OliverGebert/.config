-- ~/.config/nvim/lua/plugins/fugitive.lua
return {
  "tpope/vim-fugitive",
  lazy = false,
  cmd = {
    "G", "Gdiff", "Gvdiffsplit", "Gread", "Gwrite",
    "Glog", "Ggrep", "GMove", "GDelete", "GBrowse"
  },
  config = function()
    vim.keymap.set('n', '<leader>gs', "<cmd>G<CR>", { desc = "Git Status (Fugitive)" })
    vim.keymap.set('n', '<leader>gd', "<cmd>Gvdiffsplit<CR>", { desc = "Git Diff (HEAD vs current)" })
    vim.keymap.set('n', '<leader>gb', "<cmd>Git blame<CR>", { desc = "Git Blame" })
    vim.keymap.set('n', '<leader>gl', "<cmd>Git log<CR>", { desc = "Git Log" })
    vim.keymap.set('n', '<leader>gc', "<cmd>Git commit -v<CR>", { desc = "Git Commit" })
    vim.keymap.set('n', '<leader>gp', "<cmd>Git push<CR>", { desc = "Git Push" })  
  end,
}
