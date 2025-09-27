return {
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  opts = {
    spec = {
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      { "<leader>d", group = "[D]ebug" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>h", group = "[G]it" },
      { "<leader>x", group = "[X]Toggle" },
    },
  },
}
