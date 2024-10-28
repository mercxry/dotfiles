return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    spec = {
      {
        mode = { "n", "v" },

        -- icons:
        -- - https://www.nerdfonts.com/cheat-sheet

        -- colors:
        -- - azure
        -- - blue
        -- - cyan
        -- - green
        -- - grey
        -- - orange
        -- - purple
        -- - red
        -- - yellow

        -- sets the title of the popup
        { "<leader>", group = "leader" },

        -- general groups
        { "<leader>a", group = "ai", icon = { icon = "󰚩 ", color = "yellow" } },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "orange" } },
        { "<leader>t", group = "test" },

        -- git
        { "<leader>g", group = "git" },
        { "<leader>gp", group = "pr" },
        { "<leader>gd", group = "diff" },
        { "<leader>gc", group = "conflicts" },

        -- search
        { "<leader>s", group = "search" },
        { "<leader>sp", icon = { icon = " ", color = "blue" } },
        { "<leader>sM", icon = { icon = " ", color = "blue" } },

        -- undotree
        { "<leader>u", icon = { icon = "󰕌 ", color = "azure" } },

        -- kubectl
        { "<leader>K", icon = { icon = "󱃾 ", color = "blue" } },

        -- obsidian
        { "<leader>o", group = "obsidian", icon = { icon = "󰠮 ", color = "cyan" } },

        -- dadbod
        { "<leader>D", group = "database", icon = { icon = " ", color = "yellow" } },

        -- hidden
        { "<leader>psvg", hidden = true },
        { "<leader>]", hidden = true },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show { global = false }
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
