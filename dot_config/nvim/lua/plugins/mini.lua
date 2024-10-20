return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    lazy = false,
  -- stylua: ignore
  keys = {
    { "<C-n>",     "<cmd>lua MiniFiles.open()<CR>", desc = "Open file explorer", },
    { "<leader>e", "<cmd>lua MiniFiles.open()<CR>", desc = "Open file explorer", },
  },
    config = function()
      require("mini.ai").setup()
      require("mini.basics").setup()

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