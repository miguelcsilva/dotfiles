return {
  "echasnovski/mini.starter",
  version = false,
  config = function()
    local starter = require("mini.starter")
    local builtin = require("telescope.builtin")
    starter.setup({
      items = {
        {
          action = function()
            builtin.oldfiles({ prompt_title = "Old" })
          end,
          name = "Old",
          section = "Telescope",
        },
        {
          action = function()
            builtin.find_files({ prompt_title = "Files" })
          end,
          name = "Files",
          section = "Telescope",
        },
        {
          action = function()
            builtin.live_grep({ prompt_title = "Files" })
          end,
          name = "Grep",
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
