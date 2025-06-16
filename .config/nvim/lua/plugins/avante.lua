return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    provider = "custom_claude_35_haiku",
    providers = {
      custom_zendesk_o3_mini = {
        endpoint = "https://ai-gateway.zende.sk/v1/",
        model = "o3-mini-2025-01-31",
        api_key_name = "AVANTE_ZENDESK_API_KEY",
        __inherited_from = "openai",
      },
      custom_claude_35_haiku = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-haiku-20241022",
        api_key_name = "AVANTE_ANTHROPIC_API_KEY",
        __inherited_from = "claude",
        timeout = 30000,
        disable_tools = false,
        extra_request_body = {
          max_tokens = 8192,
          temperature = 0,
        },
      },
      custom_claude_35_sonnet = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        api_key_name = "AVANTE_ANTHROPIC_API_KEY",
        __inherited_from = "claude",
        timeout = 120000,
        disable_tools = false,
        extra_request_body = {
          max_tokens = 8192,
          temperature = 0,
        },
      },
      custom_claude_37_sonnet = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-7-sonnet-20250219",
        api_key_name = "AVANTE_ANTHROPIC_API_KEY",
        __inherited_from = "claude",
        timeout = 180000,
        disable_tools = false,
        extra_request_body = {
          max_tokens = 8192,
          temperature = 0,
        },
      },
    },
  },
}
