return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {}
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "Chat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Actions" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      { "stevearc/dressing.nvim", opts = {} },
    },
    config = function()
      local hostname = vim.fn.hostname()
      local is_draconis = hostname == "draconis.local"

      require("codecompanion").setup {
        adapters = {
          show_defaults = false,
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = is_draconis
                    and "cmd:op item get ln3dksdvm72pci7dmgfxdwuosm --reveal --fields label=credential"
                  or "ANTHROPIC_API_KEY",
              },
            })
          end,
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = is_draconis
                    and "cmd:op item get dzu4nfmu6cekgh3u4aot5ivuxu --reveal --fields label=credential"
                  or "OPENAI_API_KEY",
              },
            })
          end,
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "claude-3.7-sonnet",
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = is_draconis and "anthropic" or "copilot",
          },
          agent = {
            adapter = is_draconis and "anthropic" or "copilot",
          },
          inline = {
            adapter = is_draconis and "anthropic" or "copilot",
          },
        },
      }
    end,
  },
}
