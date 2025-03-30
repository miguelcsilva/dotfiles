return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  cmd = { "Yazi" },
  keys = {
    {
      "<leader>e",
      "<cmd>Yazi cwd<cr>",
      mode = "n",
      desc = "[E]xplore directory",
    },
  },
  opts = {},
}
