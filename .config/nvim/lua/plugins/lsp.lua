return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp", -- Allows extra capabilities provided by nvim-cmp
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local telescope_builtin = require("telescope.builtin")
        vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, { buffer = event.buf, desc = "[G]oto [D]efinition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "[G]oto [D]eclaration" })
        vim.keymap.set("n", "gr", telescope_builtin.lsp_references, { buffer = event.buf, desc = "[G]oto [R]eferences" })
        vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, { buffer = event.buf, desc = "[G]oto [I]mplementation" })
        vim.keymap.set("n", "H", vim.lsp.buf.hover, { buffer = event.buf, desc = "LSP Hover" })
        vim.keymap.set("n", "<leader>cs", telescope_builtin.lsp_document_symbols, { buffer = event.buf, desc = "[C]ode [S]ymbols (Document)" })
        vim.keymap.set("n", "<leader>cS", telescope_builtin.lsp_dynamic_workspace_symbols, { buffer = event.buf, desc = "[C]ode [S]ymbols (Workspace)" })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = event.buf, desc = "[C]ode [R]ename" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "[C]ode [A]ction" })
        vim.api.nvim_set_keymap("n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "[C]ode [D]iagnostics" })
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
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

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          vim.keymap.set("n", "<leader>xh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, { desc = "[X]Toggle Inlay [H]ints" })
        end
      end,
    })

    --  Create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      },
      -- html = {
      --   format = {
      --     templating = true,
      --     wrapLineLength = 100,
      --     wrapAttributes = 'auto',
      --   },
      --   hover = {
      --     documentation = true,
      --     references = true,
      --   },
      -- }
    }

    require("mason").setup()
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "debugpy",
      "gopls",
      "lua-language-server",
      "pyright",
      "stylua",
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
