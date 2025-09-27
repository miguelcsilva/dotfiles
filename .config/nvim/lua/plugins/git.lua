return {
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
          diff_binaries = false,
          winbar_info = true,
        },
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", mode = "n", desc = "[G]it [D]iff open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory --follow %<cr>", mode = "n", desc = "[G]it [H]istory" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", mode = "n", desc = "[G]it [C]lose" },
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
      { "<leader>gr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, mode = "v", desc = "[G]it [R]eset line" },
      { "<leader>gR", function() require("gitsigns").reset_buffer() end, mode = "n", desc = "[G]it [R]eset buffer" },
      { "<leader>gn", function() require("gitsigns").nav_hunk("next") end, mode = "n", desc = "[G]it [N]ext hunk" },
      { "<leader>gp", function() require("gitsigns").nav_hunk("prev") end, mode = "n", desc = "[G]unk [P]rev hunk" },
      { "<leader>gb", function() require("gitsigns").blame_line() end, mode = "n", desc = "[H]unk [B]lame" },
      { "<leader>gB", function() require("gitsigns").blame_line({full = true}) end, mode = "n", desc = "[H]unk [B]lame Full" },
      -- stylua: ignore end
    },
  },
}
