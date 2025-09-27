return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      "telescope",
      files = {
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden -e",
      },
      buffers = {
        sort_lastused = true,
        show_all_buffers = true,
      },
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        preview = {
          default = "bat",
        },
      },
    })

    local fzf = require("fzf-lua")

    -- Files/Buffers
    vim.keymap.set("n", "<leader><leader>", function()
      fzf.buffers({ winopts = { height = 0.4, width = 0.6 } })
    end, { desc = "Search Buffers" })
    vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>so", fzf.oldfiles, { desc = "[S]earch [O]ld" })
    -- Grep
    vim.keymap.set("n", "<leader>sg", function()
      fzf.grep_curbuf({ winopts = { height = 0.4, width = 0.6 } })
    end, { desc = "[S]earch [G]rep Buffer" })
    vim.keymap.set("n", "<leader>sG", function()
      fzf.live_grep({ prompt = "Grep Workspace> " })
    end, { desc = "[S]earch [G]rep Workspace" })
    vim.keymap.set("n", "<leader>se", function()
      fzf.live_grep({ prompt = "Exact Search> ", rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden --fixed-strings -e" })
    end, { desc = "[S]earch [E]xact" })
    vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "[S]earch [W]ord" })
    -- LSP
    vim.keymap.set("n", "<leader>sr", fzf.lsp_references, { desc = "[S]earch [R]eferences" })
    vim.keymap.set("n", "<leader>ss", fzf.lsp_document_symbols, { desc = "[S]earch [S]ymbols Buffer" })
    vim.keymap.set("n", "<leader>sS", fzf.lsp_workspace_symbols, { desc = "[S]earch [S]ymbols Workspace" })
    vim.keymap.set("n", "<leader>si", fzf.lsp_implementations, { desc = "[S]earch [I]mplementations" })
    vim.keymap.set("n", "<leader>sd", fzf.lsp_definitions, { desc = "[S]earch [D]efinitions" })
    vim.keymap.set("n", "<leader>sD", fzf.lsp_typedefs, { desc = "[S]earch Type [D]efinitions" })
    vim.keymap.set("n", "<leader>st", fzf.treesitter, { desc = "[S]earch [T]reesitter" })
    -- Misc
    vim.keymap.set("n", "<leader>sh", fzf.helptags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sn", function()
      fzf.files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })
    vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
  end,
}
