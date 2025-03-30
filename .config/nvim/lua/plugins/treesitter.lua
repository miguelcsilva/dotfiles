return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "go",
          "gomod",
          "gosum",
          "html",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "toml",
          "yaml",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      multiline_threshold = 1,
      max_lines = 5,
    },
  },
}
