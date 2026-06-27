-- Formatting
require("conform").setup({
  format_on_save = false,
  formatters_by_ft = {
    go = { "golangcilint" },
    lua = { "stylua" },
    python = {
      "ruff_fix",
      "ruff_organize_imports",
      "ruff_format",
    },
  },
  formatters = {
    ["golangcilint"] = {
      command = "go",
      args = { "tool", "golangci-lint", "fmt", "--stdin" },
    },
  },
})

vim.keymap.set("n", "<leader>f", function()
  require("conform").format()
end, { desc = "[F]ormat buffer" })

-- Linting
require("lint").linters_by_ft = {
  ["python"] = { "ruff" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
