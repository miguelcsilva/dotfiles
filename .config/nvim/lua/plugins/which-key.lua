return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    spec = {
      -- Top-level single keymaps
      { "<leader><leader>", desc = "Search Buffers" },
      { "<leader>e", desc = "[E]xplore directory" },
      { "<leader>f", desc = "[F]ormat buffer" },

      -- Code operations
      { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
      { "<leader>ca", desc = "[C]ode [A]ction" },
      { "<leader>cr", desc = "[C]ode [R]ename" },
      { "<leader>cd", desc = "[C]ode [D]iagnostics" },

      -- Debug operations
      { "<leader>d", group = "[D]ebug" },
      { "<leader>db", desc = "[D]ebug [B]reakpoint" },
      { "<leader>dB", desc = "[D]ebug [B]reakpoint Clear" },
      { "<leader>dc", desc = "[D]ebug [C]ontinue" },
      { "<leader>dC", desc = "[D]ebug Run to [C]ursor" },
      { "<leader>di", desc = "[D]ebug Step [I]nto" },
      { "<leader>dj", desc = "[D]ebug Step Dow[n]" },
      { "<leader>dk", desc = "[D]ebug Step U[p]" },
      { "<leader>dO", desc = "[D]ebug Step [O]ut" },
      { "<leader>do", desc = "[D]ebug Step [O]ver" },
      { "<leader>dp", desc = "[D]ebug [P]ause" },
      { "<leader>dr", desc = "[D]ebug Toggle [R]EPL" },
      { "<leader>ds", desc = "[D]ebug [S]ession" },
      { "<leader>dT", desc = "[D]ebug [T]erminate" },
      { "<leader>dw", desc = "[D]ebug [W]idgets" },
      { "<leader>dt", desc = "[D]ebug [T]est" },
      { "<leader>du", desc = "[D]ebug Toggle [U]I" },
      { "<leader>de", desc = "[D]ebug [E]val", mode = { "n", "v" } },

      -- Git operations
      { "<leader>g", group = "[G]it" },
      { "<leader>gd", desc = "[G]it [D]iff open" },
      { "<leader>gh", desc = "[G]it [H]istory" },
      { "<leader>gc", desc = "[G]it [C]lose" },
      { "<leader>gr", desc = "[G]it [R]eset line", mode = "v" },
      { "<leader>gR", desc = "[G]it [R]eset buffer" },
      { "<leader>gn", desc = "[G]it [N]ext hunk" },
      { "<leader>gp", desc = "[G]it [P]rev hunk" },
      { "<leader>gb", desc = "[G]it [B]lame" },
      { "<leader>gB", desc = "[G]it [B]lame Full" },

      -- Search operations
      { "<leader>s", group = "[S]earch" },
      { "<leader>sf", desc = "[S]earch [F]iles" },
      { "<leader>so", desc = "[S]earch [O]ld" },
      { "<leader>sg", desc = "[S]earch [G]rep Buffer" },
      { "<leader>sG", desc = "[S]earch [G]rep Workspace" },
      { "<leader>se", desc = "[S]earch [E]xact" },
      { "<leader>sw", desc = "[S]earch [W]ord" },
      { "<leader>sr", desc = "[S]earch [R]eferences" },
      { "<leader>ss", desc = "[S]earch [S]ymbols Buffer" },
      { "<leader>sS", desc = "[S]earch [S]ymbols Workspace" },
      { "<leader>si", desc = "[S]earch [I]mplementations" },
      { "<leader>sd", desc = "[S]earch [D]efinitions" },
      { "<leader>sD", desc = "[S]earch Type [D]efinitions" },
      { "<leader>st", desc = "[S]earch [T]reesitter" },
      { "<leader>sh", desc = "[S]earch [H]elp" },
      { "<leader>sn", desc = "[S]earch [N]eovim files" },
      { "<leader>sk", desc = "[S]earch [K]eymaps" },

      -- Toggle operations
      { "<leader>x", group = "[X]Toggle" },
      { "<leader>xh", desc = "[X]Toggle Inlay [H]ints" },
      { "<leader>xs", desc = "[X]Toggle Flash [S]earch" },
    },
  },
}
