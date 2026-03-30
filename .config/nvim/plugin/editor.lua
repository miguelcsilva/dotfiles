-- Flash
-- stylua: ignore start
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set("n", "<leader>xs", function() require("flash").toggle() end, { desc = "Toggle Flash [S]earch" })
-- stylua: ignore end

-- Yazi
vim.keymap.set("n", "<leader>e", "<cmd>Yazi<cr>", { desc = "[E]xplore directory" })

-- Auto-save (debounced)
local save_timer = vim.uv.new_timer()
local function debounced_save()
  save_timer:stop()
  save_timer:start(
    135,
    0,
    vim.schedule_wrap(function()
      if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
        vim.cmd("silent! update")
      end
    end)
  )
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, { callback = debounced_save })
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, { command = "silent! update" })
