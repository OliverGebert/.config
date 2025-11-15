return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",    -- prevents CursorHold issues
    "nvim-neotest/neotest-python",        -- Python adapter
    "nvim-neotest/neotest-go",            -- golang adapter
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
        require("neotest-go")({
          experimental = { test_table = true },
          args = { "-count=1", "-timeout=60s" },
        }),
      },
      quickfix = { enabled = false },
      output = { open_on_run = "short" },
      summary = { enabled = true, follow = true, animated = true },
    })

    -- Keymaps
    mapk('n', '<leader>us', function() neotest.run.run() end, "Unit Test: Run single" )
    mapk('n', '<leader>ul', function() neotest.run.run_last() end, "Unit Test: Run last" )
    mapk('n', '<leader>uf', function() neotest.run.run(vim.fn.expand("%")) end, "Unit Test: Run file" )
    mapk('n', '<leader>ua', function() neotest.run.run({ suite = true }) end, "Unit Test: Run all" )
    mapk('n', '<leader>uo', function() neotest.output.open({ enter = true }) end, "Unit Test: Show output" )
    mapk('n', '<leader>ut', function() neotest.summary.toggle() end, "Unit Test: Toggle pane" )
  end,
}

