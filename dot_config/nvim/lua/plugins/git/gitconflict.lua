return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    keys = {
      { "<leader>gcc", "<Plug>(git-conflict-ours)", desc = "Choose current" },
      { "<leader>gci", "<Plug>(git-conflict-theirs)", desc = "Choose incoming" },
      { "<leader>gcb", "<Plug>(git-conflict-both)", desc = "Choose both" },
      { "<leader>gc0", "<Plug>(git-conflict-none)", desc = "Ignore" },
      { "<leader>gcp", "<Plug>(git-conflict-prev-conflict)", desc = "Go to previous" },
      { "<leader>gcn", "<Plug>(git-conflict-next-conflict)", desc = "Go to next" },
    },
    config = function()
      require("git-conflict").setup {
        default_mappings = false,
      }
    end,
  },
}
