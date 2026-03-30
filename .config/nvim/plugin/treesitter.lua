require("nvim-treesitter").setup({
  ensure_installed = {
    "bash",
    "go",
    "gomod",
    "gosum",
    "html",
    "json",
    "lua",
    "python",
    "toml",
    "yaml",
  },
  auto_install = true,
})

require("treesitter-context").setup({
  multiline_threshold = 1,
  max_lines = 5,
})
