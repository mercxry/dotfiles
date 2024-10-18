return {
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
      require("codecompanion").setup {
        adapters = {
          anthropic = function()
            local anthropic_api_key = vim.fn.system {
              "op",
              "item",
              "get",
              "ln3dksdvm72pci7dmgfxdwuosm",
              "--reveal",
              "--fields",
              "label=credential",
            }

            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = anthropic_api_key,
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          agent = {
            adapter = "anthropic",
          },
        },
      }
    end,
  },
  {
    "Exafunction/codeium.vim",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },
}
