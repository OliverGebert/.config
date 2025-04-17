-- ~/.config/nvim/lua/plugins/fugitive.lua
return {
  "tpope/vim-fugitive",
  cmd = { "G", "Gdiff", "Gvdiffsplit", "Gread", "Gwrite", "Glog", "Ggrep", "GMove", "GDelete", "GBrowse" },
  keys = {
    { "<leader>gs", ":G<CR>", desc = "Git Status (Fugitive)" },
    { "<leader>gd", ":Gdiff<CR>", desc = "Git Diff (HEAD vs current)" },
    { "<leader>gb", ":Git blame<CR>", desc = "Git Blame" },
  },
  config = function()
    -- optional: Custom Fugitive settings (rarely needed)
  end,
}
