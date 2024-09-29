return { -- Autoformat
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format()
      end,
      mode = "n",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    format_on_save = false,
    formatters_by_ft = {
      lua = { "stylua" },
      python = {
        "ruff_fix",
        "ruff_organize_imports",
        "ruff_format",
      },
    },
  },
}
