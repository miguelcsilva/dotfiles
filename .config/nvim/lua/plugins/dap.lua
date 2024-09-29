return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      -- DAP Standard
      local dap = require("dap")
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
      vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
      vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
      vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }
      local vscode = require("dap.ext.vscode")
      -- setup dap config by VsCode launch.json file
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
      -- Extends dap.configurations with entries read from .vscode/launch.json
      if vim.fn.filereadable(".vscode/launch.json") then
        vscode.load_launchjs()
      end
      -- DAP Python
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
      -- DAP UI
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "[D]ebug [B]reakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "[D]ebug [B]reakpoint Clear",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "[D]ebug [C]ontinue",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "[D]ebug Run to [C]ursor",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "[D]ebug Step [I]nto",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "[D]ebug Step [D]own",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "[D]ebug Step [U]p",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "[D]ebug Step [O]ut",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "[D]ebug Step [O]ver",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "[D]ebug [P]ause",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "[D]ebug Toggle [R]EPL",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "[D]ebug [S]ession",
      },
      {
        "<leader>dT",
        function()
          require("dap").terminate()
        end,
        desc = "[D]ebug [T]erminate",
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "[D]ebug [W]idgets",
      },
      {
        "<leader>dt",
        function()
          require("dap-python").test_method()
        end,
        desc = "[D]ebug [T]est",
        ft = "python",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "[D]ebug Toggle [U]I",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "[D]ebug [E]val",
        mode = { "n", "v" },
      },
    },
  },
}
