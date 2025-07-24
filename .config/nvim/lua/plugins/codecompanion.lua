return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    local function read_secret(path)
      local f = io.open(path, "r")
      if f then
        local v = f:read("*l")
        f:close()
        return v
      end
    end
    local company_ai_gateway_url = read_secret(os.getenv("HOME") .. "/.secrets/company-ai-gateway-url")
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "company_gpt_o3",
        },
      },
      adapters = {
        opts = { show_defaults = false },
        company_gpt_o3 = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = "cmd:cat ~/.secrets/company-ai-gateway-api-key 2>/dev/null",
            },
            url = company_ai_gateway_url,
            chat = {
              model = "o3-2025-04-16",
              temperature = 0,
            },
          })
        end,
        company_gpt_o3_mini = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = "cmd:cat ~/.secrets/company-ai-gateway-api-key 2>/dev/null",
            },
            url = company_ai_gateway_url,
            chat = {
              model = "o3-mini-2025-01-31",
              temperature = 0,
            },
          })
        end,
        claude_35_haiku = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:cat ~/.secrets/anthropic-api-key 2>/dev/null",
            },
            chat = {
              model = "claude-3-5-haiku-latest",
              max_tokens = 8192,
              temperature = 0,
            },
          })
        end,
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
        },
        chat = {
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
            width = 0.45,
            height = 0.8,
            relative = "editor",
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              signcolumn = "no",
              spell = false,
              wrap = true,
            },
          },
        },
      },
    })
  end,
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "[A]I [C]hat" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "[A]I [A]ctions" },
  },
}
