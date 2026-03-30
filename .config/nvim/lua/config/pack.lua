-- PackChanged hooks (must be defined BEFORE vim.pack.add)
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  -- Theme
  "https://github.com/folke/tokyonight.nvim",

  -- Dependencies (list before plugins that need them)
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/rafamadriz/friendly-snippets",

  -- Core
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },

  -- Editor
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/folke/flash.nvim",
  "https://github.com/mikavilpas/yazi.nvim",
  "https://github.com/folke/which-key.nvim",

  -- UI
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/shellRaining/hlchunk.nvim",
  "https://github.com/echasnovski/mini.starter",
  "https://github.com/OXY2DEV/markview.nvim",

  -- Git
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/sindrets/diffview.nvim",

  -- DAP
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/mfussenegger/nvim-dap-python",

  -- Formatting & Linting
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",
})

vim.cmd.colorscheme("tokyonight-moon")
