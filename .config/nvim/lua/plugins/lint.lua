return {
  "mfussenegger/nvim-lint",
  events = "VeryLazy",
  config = function()
    require("lint").linters_by_ft = {
      ["python"] = { "ruff" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
