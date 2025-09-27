return {
  "echasnovski/mini.starter",
  version = false,
  config = function()
    local starter = require("mini.starter")
    local fzf = require("fzf-lua")
    starter.setup({
      items = {
        -- stylua: ignore start
        { action = function() fzf.oldfiles({ prompt = "Old> " }) end, name = "Old", section = "FzfLua" },
        { action = function() fzf.files({ prompt = "Files> " }) end, name = "Files", section = "FzfLua" },
        { action = function() fzf.live_grep({ prompt = "Grep> " }) end, name = "Grep", section = "FzfLua" },
        { name = "New", action = "enew", section = "Actions" },
        { name = "Quit", action = "qall", section = "Actions" },
        -- stylua: ignore end
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning("center", "center"),
      },
      footer = "",
    })
  end,
}
