return {
  "olimorris/codecompanion.nvim",
  event = "BufReadPost",
  dependencies = {
    "ellisonleao/dotenv.nvim", 
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  config = function()
    require("dotenv").setup({
      dotenv_path = vim.fn.stdpath("config"),
      enable_on_load = true,
      verbose = true,
    })
    require("codecompanion").setup({
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = os.getenv("OPENAI_API_KEY"),
            },
          })
        end,
        copilot = false,  -- redundante Absicherung (optional)
      },
      strategies = {
        chat = {
          adapter = "openai",
          keymaps = {
            send = {
              modes = { n = "<C-s>", i = "<C-s>" },
              opts = {},
            },
          },
        },
      },
      strategy = "chat",
      model = {
        name = "gpt-4o",
        temperature = 0.5,
      },
    })
    vim.keymap.set('n', '<leader>cc', "<cmd>CodeCompanionChat Toggle<CR>", { noremap = true, silent = true, desc = "Toggle CodeCompanion Chat" })
  end,
}
