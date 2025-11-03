    -- ~/.config/nvim/lua/plugins/rest.lua
return {
  "rest-nvim/rest.nvim",
  ft = { "http" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local mapk = require("utils").mapk
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
    mapk('n', '<leader>hr', "<cmd>Rest run<CR>", "HTTP: Run request")
    mapk('n', '<leader>hl', "<cmd>Rest run last<CR>", "HTTP: Rerun last request")
    mapk('n', '<leader>hp', "<cmd>Rest preview<CR>", "HTTP: Preview cURL command")
  end,
}
