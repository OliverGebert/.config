-- File: lua/plugins/minidiff.lua
return {
  "echasnovski/mini.diff",
  event = "BufReadPost",
  config = function()
    require("mini.diff").setup({
      view = {
        style = "sign", -- 'sign', 'number', 'line'
      },
      mappings = {}, -- we'll define our own below
    })

    -- Auto-enable MiniDiff on normal buffers
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function(args)
        if vim.bo[args.buf].buftype == "" then
          require("mini.diff").enable(args.buf)
        end
      end,
    })
  end,
}

