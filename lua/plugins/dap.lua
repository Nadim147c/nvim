return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mxsdev/nvim-dap-vscode-js",
      -- virtual text for the debugger
      "theHamsta/nvim-dap-virtual-text",
    },

    config = function()
      local dap = require "dap"

      local function map(key, fn, desc)
        -- Set Keymap
        vim.keymap.set("n", "<leader>d" .. key, fn, { desc = "Dap " .. desc })
      end

      -- stylua: ignore start
      map("B", function() dap.set_breakpoint(vim.fn.input "Breakpoint condition: ") end, "Breakpoint condition")
      map("b", function() dap.toggle_breakpoint() end, "Toggle Breakpoint")
      map("c", function() dap.continue() end, "Run/Continue")
      vim.keymap.set("n", "C", function() dap.continue() end, { desc = "Dap Run/continue" })
      map("a", function() dap.continue { before = get_args } end, "Run with Args")
      map("C", function() dap.run_to_cursor() end, "Run to Cursor")
      map("g", function() dap.goto_() end, "Go to Line (No Execute)")
      map("i", function() dap.step_into() end, "Step Into")
      map("j", function() dap.down() end, "Down")
      map("k", function() dap.up() end, "Up")
      map("l", function() dap.run_last() end, "Run Last")
      map("o", function() dap.step_out() end, "Step Out")
      map("O", function() dap.step_over() end, "Step Over")
      map("P", function() dap.pause() end, "Pause")
      map("r", function() dap.repl.toggle() end, "Toggle REPL")
      map("s", function() dap.session() end, "Session")
      map("t", function() dap.terminate() end, "Terminate")
      map("w", function() require("dap.ui.widgets").hover() end, "Widgets")
      -- stylua: ignore end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- setup dap config by VsCode launch.json file
      local vscode = require "dap.ext.vscode"
      local json = require "plenary.json"
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      local mason_pkgs = vim.fn.stdpath "data" .. "/mason/packages"

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            (mason_pkgs .. "/js-debug-adapter/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
      dap.adapters["pwa-bun"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "bun",
          args = {
            (mason_pkgs .. "/js-debug-adapter/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }

      for _, language in ipairs { "typescript", "javascript" } do
        dap.configurations[language] = {
          {
            name = "Launch (Bun)",
            type = "pwa-bun",
            request = "launch",
            program = "${file}",
            port = "${port}",
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            protocol = "inspector",
            console = "integratedTerminal",
          },
          {
            name = "Launch (Node)",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            port = "${port}",
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            protocol = "inspector",
            console = "integratedTerminal",
          },
        }
      end
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = "nvim-neotest/nvim-nio",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle {} end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Dap Eval", mode = { "n", "v" } },
    },
    opts = {},
    config = function(_, opts)
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup(opts)

      -- stylua: ignore start
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end
      -- stylua: ignore end
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    event = "VeryLazy",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {},
    },
    config = true,
  },
}
