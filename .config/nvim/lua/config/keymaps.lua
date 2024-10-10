vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<M-h>", "<cmd>vertical resize -2<cr>", { desc = "Shrink window horizontally" })
vim.keymap.set("n", "<M-l>", "<cmd>vertical resize +2<cr>", { desc = "Enlarge window vertically" })
vim.keymap.set("n", "<M-k>", "<cmd>resize +2<cr>", { desc = "Enlarge window vertically" })
vim.keymap.set("n", "<M-j>", "<cmd>resize -2<cr>", { desc = "Shrink window vertically" })

vim.keymap.set("n", "sv", ":vsplit<Return>", { desc = "Split vertically" })
vim.keymap.set("n", "ss", ":hsplit<Return>", { desc = "Split horizontally" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent lines left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent lines right" })
