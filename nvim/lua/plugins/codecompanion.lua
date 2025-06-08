return {
  "olimorris/codecompanion.nvim",
  event = "BufReadPost",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "MeanderingProgrammer/render-markdown.nvim",
    "akinsho/toggleterm.nvim",
  },
  config = function()
   require("codecompanion").setup({
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = os.getenv("OPENAI_API_KEY")
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
          ui = function()
            -- Function to open ToggleTerm and run CodeCompanion chat in it
            local Terminal = require("toggleterm.terminal").Terminal
            local chat_term = Terminal:new({
              direction = "vertical",
              close_on_exit = false,
              on_open = function(term)
                vim.api.nvim_feedkeys(":CodeCompanionChat<CR>", "n", false)
              end,
            })
            chat_term:toggle()
          end,
        },
      },
      model = {
        name = "gpt-4o",
        temperature = 0.5,
      },
    })
    vim.keymap.set('n', '<leader>cc', "<cmd>CodeCompanionChat Toggle<CR>", { noremap = true, silent = true, desc = "Toggle CodeCompanion Chat" })
  end,
}
