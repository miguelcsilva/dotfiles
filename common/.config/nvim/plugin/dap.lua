local dap = require("dap")

-- Signs
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

-- Python
require("dap-python").setup()
require("dap-python").test_runner = "pytest"

-- DAP UI
local dapui = require("dapui")
dapui.setup({
  layouts = {
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      position = "bottom",
      size = 15,
    },
  },
})
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

-- Keymaps
-- stylua: ignore start
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "[D]ebug [B]reakpoint" })
vim.keymap.set("n", "<leader>dB", function() dap.clear_breakpoints() end, { desc = "[D]ebug [B]reakpoint Clear" })
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "[D]ebug [C]ontinue" })
vim.keymap.set("n", "<leader>dC", function() dap.run_to_cursor() end, { desc = "[D]ebug Run to [C]ursor" })
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "[D]ebug Step [I]nto" })
vim.keymap.set("n", "<leader>dj", function() dap.down() end, { desc = "[D]ebug Step [D]own" })
vim.keymap.set("n", "<leader>dk", function() dap.up() end, { desc = "[D]ebug Step [U]p" })
vim.keymap.set("n", "<leader>dO", function() dap.step_out() end, { desc = "[D]ebug Step [O]ut" })
vim.keymap.set("n", "<leader>do", function() dap.step_over() end, { desc = "[D]ebug Step [O]ver" })
vim.keymap.set("n", "<leader>dp", function() dap.pause() end, { desc = "[D]ebug [P]ause" })
vim.keymap.set("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "[D]ebug Toggle [R]EPL" })
vim.keymap.set("n", "<leader>ds", function() dap.session() end, { desc = "[D]ebug [S]ession" })
vim.keymap.set("n", "<leader>dT", function() dap.terminate() end, { desc = "[D]ebug [T]erminate" })
vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "[D]ebug [W]idgets" })
vim.keymap.set("n", "<leader>dt", function() require("dap-python").test_method() end, { desc = "[D]ebug [T]est" })
vim.keymap.set("n", "<leader>du", function() dapui.toggle({}) end, { desc = "[D]ebug Toggle [U]I" })
vim.keymap.set({ "n", "v" }, "<leader>de", function() dapui.eval() end, { desc = "[D]ebug [E]val" })
-- stylua: ignore end
