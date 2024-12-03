return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>e", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", mode = "n", desc = "File [E]xplorer" },
  },
  config = function()
    local fb_actions = require("telescope").extensions.file_browser.actions

    require("telescope").setup({
      defaults = { --[[ your defaults]]
      },
      extensions = {
        file_browser = {
          ["n"] = {
            c = fb_actions.create,
            r = fb_actions.rename,
            m = fb_actions.move,
            y = fb_actions.copy,
          },
        },
      },
    })
  end,
}
