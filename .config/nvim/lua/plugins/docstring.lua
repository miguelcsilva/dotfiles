return {
  "danymat/neogen",
  config = true,
  opts = {
    enabled = true,
    languages = {
      python = {
        template = {
          annotation_convention = "google_docstrings",
        },
      },
    },
  },
  keys = {
    {
      "<leader>cn",
      function()
        require("neogen").generate()
      end,
      mode = "n",
      desc = "[C]ode A[N]notation",
    },
  },
  version = "*",
}
