-- Basic
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<C-c>", ":q!<CR>")

-- Visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent lines left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent lines right" })

-- Jumping windows
vim.keymap.set("n", "<C-w><Left>", "<C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-w><Right>", "<C-w>l", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-w><Down>", "<C-w>j", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-w><Up>", "<C-w>k", { desc = "Move focus to the upper window" })

-- Resizing windows
vim.keymap.set("n", "<M-h>", "<cmd>vertical resize -2<cr>", { desc = "Shrink window horizontally" })
vim.keymap.set("n", "<M-l>", "<cmd>vertical resize +2<cr>", { desc = "Enlarge window horizontally" })
vim.keymap.set("n", "<M-j>", "<cmd>resize -2<cr>", { desc = "Shrink window vertically" })
vim.keymap.set("n", "<M-k>", "<cmd>resize +2<cr>", { desc = "Enlarge window vertically" })
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Shrink window horizontally" })
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Enlarge window horizontally" })
vim.keymap.set("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Shrink window vertically" })
vim.keymap.set("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Enlarge window vertically" })

-- Splitting windows
vim.keymap.set("n", "sv", ":vsplit<Return>", { desc = "Split vertically" })
vim.keymap.set("n", "ss", ":split<Return>", { desc = "Split horizontally" })
