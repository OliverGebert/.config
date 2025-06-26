    -- ~/.config/nvim/lua/plugins/rest.lua
return {
  "rest-nvim/rest.nvim",
  ft = { "http" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local utils = require("utils")
    require("rest-nvim").setup({
      result_split_horizontal = false, -- true: horizontal split, false: vertical
      skip_ssl_verification = false,
      encode_url = true,
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        show_url = true,
        show_http_info = true,
        show_headers = true,
      },
      jump_to_request = false,
      env_file = ".env",
      custom_dynamic_variables = {},
      yank_dry_run = true,
    })

    -- Optionales Keymapping
    vim.keymap.set('n', '<leader>ca', ":CodeCompanionActions<CR>", utils.map_opts("Show CodeCompanion Action Menue"))
    vim.keymap.set('n', '<leader>ar', "<cmd>Rest run<CR>", utils.map_opts("Run HTTP request"))
    vim.keymap.set('n', '<leader>al', "<cmd>Rest run last<CR>", utils.map_opts("Rerun last request" ))
    vim.keymap.set('n', '<leader>ap', "<cmd>Rest preview<CR>", utils.map_opts("Preview cURL command" ))
  end,
}
