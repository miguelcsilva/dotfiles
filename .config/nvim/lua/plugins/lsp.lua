return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "williamboman/mason.nvim",
  },
  {
    name = "native-lsp",
    dir = vim.fn.stdpath("config"),
    config = function()
      local servers = { "cssls", "gopls", "html", "lua_ls", "pyright" }

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local server_configs = {
        cssls = { filetypes = { "css", "scss", "less" }, capabilities = capabilities },
        gopls = { filetypes = { "go", "gomod", "gowork", "gotmpl" }, capabilities = capabilities },
        html = { filetypes = { "html" }, capabilities = capabilities },
        lua_ls = { filetypes = { "lua" }, capabilities = capabilities },
        pyright = { filetypes = { "python" }, capabilities = capabilities },
      }

      for _, server_name in ipairs(servers) do
        local config = server_configs[server_name]
        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
      end

      -- Auto-start LSP servers for matching filetypes
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          for _, server_name in ipairs(servers) do
            local config = server_configs[server_name]
            if config.filetypes and vim.tbl_contains(config.filetypes, ft) then
              local start_config = vim.tbl_deep_extend("force", {
                name = server_name,
                cmd = { server_name },
              }, config)
              vim.lsp.start(start_config, { bufnr = args.buf })
              break
            end
          end
        end,
      })

      -- Preserve existing LSP keymaps and functionality
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local telescope_builtin = require("telescope.builtin")
          vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, { buffer = event.buf, desc = "[G]oto [D]efinition" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "[G]oto [D]eclaration" })
          vim.keymap.set("n", "gr", telescope_builtin.lsp_references, { buffer = event.buf, desc = "[G]oto [R]eferences" })
          vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, { buffer = event.buf, desc = "[G]oto [I]mplementation" })
          vim.keymap.set("n", "H", vim.lsp.buf.hover, { buffer = event.buf, desc = "LSP Hover" })
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = event.buf, desc = "[C]ode [R]ename" })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "[C]ode [A]ction" })
          vim.api.nvim_set_keymap("n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "[C]ode [D]iagnostics" })

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set("n", "<leader>xh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, { desc = "[X]Toggle Inlay [H]ints" })
          end
        end,
      })
    end,
  },
}
