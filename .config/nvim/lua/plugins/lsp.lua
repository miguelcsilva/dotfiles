return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    require("mason").setup()

    local servers = {
      ["css-lsp"] = {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
        root_markers = { "package.json", ".git" },
        name = "cssls",
      },
      gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
        settings = {
          gopls = {
            ["ui.inlayhint.hints"] = {
              compositeLiteralFields = true,
              constantValues = true,
              parameterNames = true,
            },
          },
        },
      },
      ["html-lsp"] = {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        root_markers = { "package.json", ".git" },
        name = "html",
      },
      ["lua-language-server"] = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
        name = "lua_ls",
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
          },
        },
      },
      ["pyright"] = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
        name = "pyright",
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      },
      templ = {
        cmd = { "go", "tool", "templ", "lsp" },
        filetypes = { "templ" },
        root_markers = { "go.work", "go.mod", ".git" },
        settings = {},
      },
    }

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    for mason_name, config in pairs(servers) do
      local lsp_name = config.name or mason_name
      config.capabilities = capabilities
      vim.lsp.config(lsp_name, config)
      vim.lsp.enable(lsp_name)
    end

    require("mason-tool-installer").setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local fzf = require("fzf-lua")
        vim.keymap.set("n", "gd", fzf.lsp_definitions, { buffer = event.buf, desc = "[G]oto [D]efinition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "[G]oto [D]eclaration" })
        vim.keymap.set("n", "gr", fzf.lsp_references, { buffer = event.buf, desc = "[G]oto [R]eferences" })
        vim.keymap.set("n", "gi", fzf.lsp_implementations, { buffer = event.buf, desc = "[G]oto [I]mplementation" })
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
}
