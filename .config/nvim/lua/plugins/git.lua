return {
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      -- stylua: ignore start
      { "<leader>if", "<cmd>DiffviewFileHistory --follow %<cr>", mode = "n", desc = "D[i]ff [F]ile" },
      { "<leader>ir", "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", mode = "n", desc = "D[i]ff [R]ange" },
      { "<leader>il", "<Cmd>.DiffviewFileHistory --follow<CR>", mode = "n", desc = "D[i]ff [L]ine" },
      { "<leader>io", "<cmd>DiffviewOpen<cr>", mode = "n", desc = "D[i]ff [O]pen" },
      { "<leader>ic", "<cmd>DiffviewClose<cr>", mode = "n", desc = "D[i]ff [C]lose" },
      -- stylua: ignore end
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    opts = {
      attach_to_untracked = true,
    },
      -- stylua: ignore start
    keys = {
      { "<leader>hr", function() require("gitsigns").reset_hunk() end, mode = "n", desc = "[H]unk [R]eset" },
      { "<leader>hr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, mode = "v", desc = "[H]unk [R]eset" },
      { "<leader>hR", function() require("gitsigns").reset_buffer() end, mode = "n", desc = "[H]unk [R]eset Buffer" },
      { "<leader>hn", function() require("gitsigns").nav_hunk("next") end, mode = "n", desc = "[H]unk [N]ext" },
      { "<leader>hp", function() require("gitsigns").nav_hunk("prev") end, mode = "n", desc = "[H]unk [P]rev" },
      { "<leader>hb", function() require("gitsigns").blame_line() end, mode = "n", desc = "[H]unk [B]lame" },
      { "<leader>hB", function() require("gitsigns").blame_line({full = true}) end, mode = "n", desc = "[H]unk [B]lame Full" },
      { "<leader>hd", function() require("gitsigns").diffthis() end, mode = "n", desc = "[H]unk [D]iff" },
      -- stylua: ignore end
    },
  },
}
