return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = { "--hidden" },
        },
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          theme = "dropdown",
          previewer = true,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
          },
        },
      },
      defaults = {
        file_ignore_patterns = { "^%.git/" },
        path_display = { shorten = { len = 2, exclude = { 1, -1 } } },
      },
    })
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    local builtin = require("telescope.builtin")
    local dropdown = require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
    -- stylua: ignore start
    -- Files/Buffers
    vim.keymap.set("n", "<leader><leader>", function() builtin.buffers(dropdown) end, { desc = "Search Buffers" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = "[S]earch [O]ld" })
    -- Grep
    vim.keymap.set("n", "<leader>sg", function() builtin.current_buffer_fuzzy_find(dropdown) end, { desc = "[S]earch [G]rep Buffer" })
    vim.keymap.set("n", "<leader>sG", function() builtin.live_grep({ prompt_title = "Grep Workspace" }) end, { desc = "[S]earch [G]rep Workspace" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })
    -- LSP
    vim.keymap.set("n", "<leader>sr", builtin.lsp_references, { desc = "[S]earch [R]eferences" })
    vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "[S]earch [S]ymbols Buffer" })
    vim.keymap.set("n", "<leader>sS", builtin.lsp_workspace_symbols, { desc = "[S]earch [S]ymbols Workspace" })
    vim.keymap.set("n", "<leader>si", builtin.lsp_implementations, { desc = "[S]earch [I]mplementations" })
    vim.keymap.set("n", "<leader>sd", builtin.lsp_definitions, { desc = "[S]earch [D]efinitions" })
    vim.keymap.set("n", "<leader>sD", builtin.lsp_type_definitions, { desc = "[S]earch Type [D]efinitions" })
    vim.keymap.set("n", "<leader>st", builtin.treesitter, { desc = "[S]earch [T]reesitter" })
    -- Misc
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sn", function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = "[S]earch [N]eovim files" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
  end,
}
