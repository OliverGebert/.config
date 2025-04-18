return {
  'lervag/vimtex',
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release

  init = function()
    -- TOC-Konfiguration
    vim.g.vimtex_toc_config = {
      name = 'TOC',
      layers = { 'content' },
      split_width = 40,
      tocdepth = 3,
      show_help = 0,
      show_numbers = 1,
      resize = 1,    -- VimTeX configuration goes here, e.g.
    }
    vim.g.vimtex_quickfix_ignore_filters = {
      'Overfull',
      'Underfull',
      'Warning',
--      'Font shape',
--      'Citation',
    }
    vim.g.maplocalleader = " "
    vim.g.vimtex_view_method = "zathura"
    vim.keymap.set("n", "<leader>lk", ":VimtexTocToggle<CR>", { desc = "Toggle TOC" })
    vim.keymap.set("n", "<leader>lc", ":VimtexClean<CR>", { desc = "clean compiler files after problem" })
  end
}
