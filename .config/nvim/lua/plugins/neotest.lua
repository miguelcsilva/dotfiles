return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          python = ".venv/bin/python",
        }),
        require("neotest-plenary"),
      },
    })
  end,
    -- stylua: ignore
    keys = {
        { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[[T]]est File" },
        { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[[T]]est All Files" },
        { "<leader>tr", function() require("neotest").run.run() end, desc = "[T]est Nea[R]est" },
        { "<leader>tl", function() require("neotest").run.run_last() end, desc = "[T]est [L]ast" },
        { "<leader>tS", function() require("neotest").run.stop() end, desc = "[T]est [S]top" },
        { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "[T]oggle [S]ummary" },
        { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[T]oggle [O]utput" },
        { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "[T]oggle [O]utput Panel" },
        { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "[T]oggle [W]atch" },
    },
}
