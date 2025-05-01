return {
  'lervag/vimtex',
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release

  init = function()
    -- Setze latexmk als bevorzugten Compiler
    vim.g.vimtex_compiler_method = "latexmk"
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
    vim.keymap.set("n", "<leader>xt", ":VimtexTocToggle<CR>", { desc = "Toggle TOC" })
    vim.keymap.set("n", "<leader>xc", ":VimtexClean<CR>", { desc = "clean compiler files after problem" })
    vim.keymap.set("n", "<leader>xv", ":VimtexView<CR>", { desc = "view PDF of current Latex file" })
    vim.keymap.set("n", "<leader>xx", ":VimtexCompile<CR>", { desc = "Toggle latex compiler on/off" })
    vim.keymap.set("n", "<leader>xe", ":VimtexQuickfix<CR>", { desc = "Toggle latex compiler on/off" })
    -- toggle spell check
    vim.keymap.set("n", "<leader>xs", function()
      vim.opt_local.spelllang = { "de", "en_us" }     -- Sprache setzen
      vim.opt_local.spell = not vim.wo.spell          -- toggle spell on/off
    end, { desc = "Spellcheck (de/en) toggeln" })
    --  Automatischer Zeilenumbruch bei 80 Zeichen für .tex Dateien
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function()
        vim.opt_local.textwidth = 80
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.formatoptions:append("t") -- Automatischer Umbruch beim Tippen
      end,
    }) 
end
}
