local ensure_installed = {
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
}

-- Install missing parsers (runs async in the background)
local installed = require("nvim-treesitter").get_installed()
local to_install = vim.tbl_filter(function(lang)
  return not vim.list_contains(installed, lang)
end, ensure_installed)

if #to_install > 0 then
  require("nvim-treesitter.install").install(to_install)
end

-- Enable treesitter highlighting for all filetypes with an available parser
-- (Neovim 0.12 only auto-starts it for bundled languages)
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

require("treesitter-context").setup({
  multiline_threshold = 1,
  max_lines = 5,
})
