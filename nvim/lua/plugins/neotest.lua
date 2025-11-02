return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim", -- prevents CursorHold issues
    "nvim-neotest/neotest-python",        -- Python adapter
  },

  config = function()
    local neotest = require("neotest")
    local mapk = require("utils").mapk

    -- Detect project .venv or fallback to system python
    local function get_python_path()
      local venv_path = vim.fn.getcwd() .. "/.venv/bin/python"
      if vim.fn.executable(venv_path) == 1 then
        return venv_path
      end
      local fallback = vim.fn.exepath("python3") or "python"
      vim.notify(
        "[neotest] No .venv found, using system python: " .. fallback,
        vim.log.levels.WARN
      )
      return fallback
    end

    neotest.setup({
      adapters = {
        require("neotest-python")({
          python = get_python_path,
          runner = "pytest",
          dap = { justMyCode = false },
        }),
      },
      quickfix = { enabled = false },
      output = { open_on_run = "short" },
      summary = { enabled = true, follow = true, animated = true },
    })

    -- Keymaps
    mapk('n', '<leader>ns', function() neotest.run.run() end, "Run single test" )
    mapk('n', '<leader>nl', function() neotest.run.run_last() end, "Run last test" )
    mapk('n', '<leader>nf', function() neotest.run.run(vim.fn.expand("%")) end, "Run tests in file" )
    mapk('n', '<leader>na', function() neotest.run.run({ suite = true }) end, "Run all tests" )
    mapk('n', '<leader>no', function() neotest.output.open({ enter = true }) end, "Show test output" )
    mapk('n', '<leader>nt', function() neotest.summary.toggle() end, "Toggle test pane" )
  end,
}

