return {
  'lervag/vimtex',
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release

  init = function()
    -- VimTeX configuration goes here, e.g.

    vim.g.vimtex_quickfix_ignore_filters = {
      'Overfull',
      'Underfull',
      'Warning',
--      'Font shape',
--      'Citation',
    }
    vim.g.maplocalleader = " "
    vim.g.vimtex_view_method = "zathura"
  end
}
