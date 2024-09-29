return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "[B]uffer [P]in" },
    {
      "<leader>bP",
      "<Cmd>BufferLineGroupClose ungrouped<CR>",
      desc = "[B]uffer Delete Non-[P]inned",
    },
    { "<leader>bd", "<Cmd>BufferLinePickClose<CR>", desc = "[B]uffer [D]elete" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "[B]uffer Delete [O]thers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "[B]uffer Delete [R]ight" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "[B]uffer Delete [L]eft" },
    { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
    { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
  },
  config = function()
    require("bufferline").setup({
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
      },
    })
  end,
}
