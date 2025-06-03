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
    vim.keymap.set('n', '<leader>gd', "<cmd>Gdiff<CR>", { desc = "Git Diff (HEAD vs current)" })
    vim.keymap.set('n', '<leader>gb', "<cmd>Git blame<CR>", { desc = "Git Blame" })
  end,
}
