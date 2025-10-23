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
    local opts = { noremap = true, silent = true }

    vim.keymap.set('n', '<leader>ns', function() neotest.run.run() -- run single test
    end, vim.tbl_extend("force", opts, { desc = "Run single test" }))

    vim.keymap.set('n', '<leader>nl', function() neotest.run.run_last() -- run last test
    end, vim.tbl_extend("force", opts, { desc = "Run last test" }))

    vim.keymap.set('n', '<leader>nf', function() neotest.run.run(vim.fn.expand("%")) -- run tests in file
    end, vim.tbl_extend("force", opts, { desc = "Run tests in file" }))

    vim.keymap.set('n', '<leader>na', function() neotest.run.run({ suite = true }) -- run all tests
    end, vim.tbl_extend("force", opts, { desc = "Run all tests" }))

    vim.keymap.set('n', '<leader>no', function() neotest.output.open({ enter = true }) -- show test output
    end, vim.tbl_extend("force", opts, { desc = "Show test output" }))

    vim.keymap.set('n', '<leader>nt', function() neotest.summary.toggle() -- toggle test pane
    end, vim.tbl_extend("force", opts, { desc = "Toggle test pane" }))

  end,
}

