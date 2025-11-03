return {
  "olimorris/codecompanion.nvim",
  event = "BufReadPost",
  dependencies = {
    -- Essential Lua functions used by many plugins
    "nvim-lua/plenary.nvim",
    -- Treesitter: Improved syntax highlighting and code parsing
    "nvim-treesitter/nvim-treesitter",
    -- Render Markdown: Provides Markdown preview/rendering in Neovim
    "MeanderingProgrammer/render-markdown.nvim",
    -- ToggleTerm: Integrated terminal management in Neovim
    "akinsho/toggleterm.nvim",
  },
  config = function()
    local mapk = require("utils").mapk
    -- local utils = require("utils")
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
          diff = "mini_diff",
        },
        cmd = {
          adapter = "openai",
        },
        chat = {
          roles = { user = "oli" },
          auto_scroll = false,  -- no automatioc scrolling by response stream
          adapter = "openai",
          keymaps = {},
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
    mapk('n', '<leader>ca', ":CodeCompanionActions<CR>", "CodeCompanion Action Menue")
    mapk('n', '<leader>cc', ":CodeCompanionChat Toggle<CR>", "CodeCompanionChat Toggle")
    mapk('vx', '<leader>cu', ":'<,'> CodeCompanionChat /unit tests<CR>", "CodeCompanionChat create unit tests")
    mapk('vx', '<leader>ce', ":'<,'> CodeCompanionChat /explain<CR>", "CodeCompanionChat explain block")
    mapk('ni', '<C-s>', function() require("codecompanion.chat").send() end, "CodeCompanion send current chat input")
    mapk('vx', '<leader>cd', ":'<,'> CodeCompanion #lsp add inline documentation to explain code<CR>", "CodeCompanion add documentation to block")
    mapk('vx', '<leader>cf', ":'<,'> CodeCompanion #lsp /fix code. No other change<CR>", "CodeCompanion fix block")
  end,
}
