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
        inline = {
          adapter = "openai",
        },
        cmd = {
          adapter = "openai",
        },
        chat = {
          roles = { user = "Oli" },
          auto_scroll = false,  -- no automatioc scrolling by response stream
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
        temperature = 0.3,
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
      },
    })
    vim.keymap.set('n', '<leader>ca', "<cmd>CodeCompanionActions<CR>", { noremap = true, silent = true, desc = "Show CodeCompanion Action Menue" })
    vim.keymap.set('n', '<leader>cc', "<cmd>CodeCompanionChat Toggle<CR>", { noremap = true, silent = true, desc = "Toggle CodeCompanion Chat" })
    vim.keymap.set('n', '<leader>ci', "<cmd>CodeCompanion<CR>", { noremap = true, silent = true, desc = "CodeCompanion inline change by prompt" })
  end,
}
