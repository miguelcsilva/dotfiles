return {
  "echasnovski/mini.starter",
  version = false,
  config = function()
    local starter = require("mini.starter")
    starter.setup({
      items = {
        {
          action = "Telescope oldfiles",
          name = "Recent",
          section = "Telescope",
        },
        {
          action = "Telescope find_files",
          name = "Files",
          section = "Telescope",
        },
        {
          action = "Telescope live_grep",
          name = "Grep",
          section = "Telescope",
        },
        {
          action = "Telescope help_tags",
          name = "Help",
          section = "Telescope",
        },
        { name = "New", action = "enew", section = "Actions" },
        { name = "Quit", action = "qall", section = "Actions" },
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning("center", "center"),
      },
      footer = "",
    })
  end,
}
