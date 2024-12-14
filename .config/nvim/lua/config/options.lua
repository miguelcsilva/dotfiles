-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Fonts
vim.g.have_nerd_font = true

-- Options
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldmethod = "syntax"
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = false
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
})

-- Auto-commands
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
