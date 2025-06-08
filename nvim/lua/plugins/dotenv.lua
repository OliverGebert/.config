return {
  "ellisonleao/dotenv.nvim",
  config = function()
    require("dotenv").setup({
      dotenv_path = vim.fn.stdpath("config"), -- entspricht ~/.config/nvim/.env
      verbose = false,
    })
  end
}

