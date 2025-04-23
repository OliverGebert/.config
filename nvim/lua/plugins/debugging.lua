return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")
      dap.adapters.python = {
        type = "executable",
        command = "/Library/Frameworks/Python.framework/Versions/3.12/bin/python3",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",  -- Das aktuelle Python-Skript
          pythonPath = function()
            return "/usr/local/bin/python"  -- Pfad zum Interpreter
          end
        },
      }
      dapui.setup({
        icons = {
          expanded = "▾",      -- Für erweiterte Menüs
          collapsed = "▸",     -- Für geschlossene Menüs
          current_frame = "🟢" -- Aktueller Frame im Stack
        },
        layouts = {
          {
            elements = {
              "scopes",       -- Zeigt Variablen an
              "repl",        -- Debug-REPL
            },
            size = 18,
            position = "bottom",
          },
          {
            elements = {
              "breakpoints",  -- Liste der Breakpoints
              "stacks",       -- Call Stack
              "watches",      -- Watch-Ausdrücke
              "console",     -- Debug-Konsole
            },
            size = 40, -- Größe des Layouts (horizontal/vertikal)
            position = "left",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "rounded", -- Rahmenstil: "rounded", "single", "double"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Maximale Länge der Variablen-/Typanzeige
        }
      })
      vim.fn.sign_define("DapBreakpoint", {
        text = "🔴",
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = "DapBreakpoint",
      })
      vim.fn.sign_define("DapBreakpointCondition", {
        text = "🟡",
        texthl = "DapBreakpointCondition",
        linehl = "",
        numhl = "DapBreakpointCondition",
      })
      vim.fn.sign_define("DapLogPoint", {
        text = "🟢",
        texthl = "DapLogPoint",
        linehl = "",
        numhl = "DapLogPoint",
      })
      dap_python.setup("/Library/Frameworks/Python.framework/Versions/3.12/bin/python3")  -- Pfad zu deinem Python-Interpreter

      -- setup for dap
      vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end)
      vim.keymap.set('n', '<leader>dc', function() dap.continue() end)
      vim.keymap.set('n', '<leader>dt', function() dap.terminate() end)
      vim.keymap.set('n', '<leader>dv', function() dap.step_over() end)
      vim.keymap.set('n', '<leader>di', function() dap.step_into() end)
      vim.keymap.set('n', '<leader>do', function() dap.step_out() end)

      -- Setup for nvim-dap-ui
      vim.keymap.set('n', '<Leader>du', function() dapui.toggle() end)
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  }
}
