-- Kulala: REST client for .http / .rest files
require("kulala").setup({
  -- Kulala fetches and builds the kulala-http parser itself (needs the tree-sitter CLI)
  treesitter = { enable = true },
  session = { restore = false },
  ui = {
    display_mode = "split",
    split_direction = "vertical",
    default_view = "body",
  },
  -- Built-in keymap set; most entries are gated to the http/rest filetypes
  global_keymaps = true,
  global_keymaps_prefix = "<leader>r",
  kulala_keymaps = true,
})
