return {
  'lervag/vimtex',
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release

  init = function()
    local mapk = require("utils").mapk
    -- Compiler-Optionen für latexmk
    vim.g.vimtex_compiler_latexmk = {
      build_dir = '',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        '-pdf',
        '-shell-escape',        -- wichtig für Glossaries / TikZ etc.
        '-interaction=nonstopmode',
        '-synctex=1',
      },
    }
    --vim.g.vimtex_compiler_method = "latexmk --shell-escape"
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

    vim.g.maplocalleader = ' '
    vim.g.vimtex_view_method = 'zathura'
 
    mapk('n', '<leader>xc', ":VimtexClean<CR>", "Vimtex: clean compiler files" )
    mapk('n', '<leader>xe', ":VimtexQuickfix<CR>", "Vimtex: Show quickfix" )
    mapk('n', '<leader>xx', function()        --, Vimtex: toggle compiler
        vim.cmd('VimtexCompile')
        vim.g.compiler_enabled = not vim.g.compiler_enabled
    end, "Toggle latex compiler on/off" )
    mapk('n', '<leader>xs', function()  --, Vimtex: toggle spell check
      vim.g.spell_enabled = not vim.g.spell_enabled
      vim.opt.spell = vim.g.spell_enabled
      vim.notify(
        "Spellcheck " .. (vim.g.spell_enabled and "aktiviert ✅" or "deaktiviert ❌"),
        vim.log.levels.INFO
      )
      -- Ltex-Diagnosen im aktuellen Buffer toggeln
      for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
        if client.name == "ltex" then
          if vim.g.spell_enabled then
            vim.diagnostic.enable(0)
          else
            vim.diagnostic.disable(0)
          end
        end
      end
    end, "Spell + Ltex toggeln" )

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'tex',
      callback = function()
        vim.opt_local.textwidth = 80
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.formatoptions:append('t') -- Automatischer Umbruch beim Tippen
      end,
    }) 
end
}
