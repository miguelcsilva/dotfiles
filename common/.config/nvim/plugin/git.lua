-- Diffview
require("diffview").setup({
  enhanced_diff_hl = true,
  view = {
    merge_tool = {
      layout = "diff3_mixed",
      disable_diagnostics = true,
      diff_binaries = false,
      winbar_info = true,
    },
  },
})

vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "[G]it [D]iff open" })
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory --follow %<cr>", { desc = "[G]it [H]istory" })
vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "[G]it [C]lose" })

-- Gitsigns
require("gitsigns").setup({
  attach_to_untracked = true,
  current_line_blame = true,
  word_diff = false,
})

-- stylua: ignore start
vim.keymap.set("v", "<leader>gr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "[G]it [R]eset line" })
vim.keymap.set("n", "<leader>gR", function() require("gitsigns").reset_buffer() end, { desc = "[G]it [R]eset buffer" })
vim.keymap.set("n", "<leader>gn", function() require("gitsigns").nav_hunk("next") end, { desc = "[G]it [N]ext hunk" })
vim.keymap.set("n", "<leader>gp", function() require("gitsigns").nav_hunk("prev") end, { desc = "[G]it [P]rev hunk" })
vim.keymap.set("n", "<leader>gb", function() require("gitsigns").blame_line() end, { desc = "[G]it [B]lame" })
vim.keymap.set("n", "<leader>gB", function() require("gitsigns").blame_line({ full = true }) end, { desc = "[G]it [B]lame Full" })
-- stylua: ignore end
