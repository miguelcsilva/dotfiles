return {
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  opts = {
    spec = {
      { "<leader>b", group = "[B]uffer" },
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      { "<leader>d", group = "[D]ebug" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>t", group = "[T]est" },
      { "<leader>h", group = "[H]unk" },
      { "<leader>x", group = "[X]Toggle" },
    },
  },
}
