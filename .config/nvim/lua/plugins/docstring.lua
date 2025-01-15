return {
  "kkoomen/vim-doge",
  event = { "BufReadPre", "BufNewFile" },
  build = ":call doge#install()", -- had to be run manually
  config = function()
    vim.g.doge_doc_standard_python = "google"
    vim.keymap.set("n", "<leader>co", "<Plug>(doge-generate)", { desc = "[C]ode d[O]cstring" })
  end,
}
