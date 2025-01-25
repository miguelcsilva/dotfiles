return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local browser = require("telescope").extensions.file_browser
    vim.keymap.set("n", "<leader>e", function()
      browser.file_browser({ path = "%:p:h", select_buffer = true, hidden = true })
    end, { desc = "File [E]xplorer" })
  end,
}
