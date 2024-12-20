return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    lazy = false,
    -- stylua: ignore
    keys = {
      { "<C-n>", "<cmd>lua MiniFiles.open()<CR>", desc = "Open file explorer", },
      {
        "<leader>e",
        function()
          local MiniFiles = require("mini.files")
          local _ = MiniFiles.close()
              or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
          vim.schedule(function()
            MiniFiles.reveal_cwd()
          end)
        end,
        desc = "Open file explorer at cwd",
      },
    },
    config = function()
      require("mini.basics").setup()

      local ai = require "mini.ai"
      ai.setup {
        n_lines = 500,
        custom_textobjects = {
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" },
        },
      }

      require("mini.files").setup {
        options = {
          use_as_default_explorer = true,
        },
        mappings = {
          go_in_plus = "<CR>",
        },
        windows = {
          preview = true,
          width_nofocus = 25,
          width_preview = 100,
        },
      }
    end,
  },
}
