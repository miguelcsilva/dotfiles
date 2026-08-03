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
  global_keymaps = {
    ["Close window"] = {
      "<leader>rq",
      function()
        local request_buf = require("kulala.db").current_buffer
        if not vim.api.nvim_buf_is_valid(request_buf or -1) then
          request_buf = vim.bo.filetype ~= "kulala_ui" and vim.api.nvim_get_current_buf() or nil
        end

        require("kulala.ui").close_kulala_buffer()
        if request_buf then
          vim.api.nvim_buf_delete(request_buf, { force = true })
        end
      end,
      ft = { "http", "rest", "kulala_ui" },
      desc = "Close window",
    },
  },
  global_keymaps_prefix = "<leader>r",
  kulala_keymaps = true,
})
