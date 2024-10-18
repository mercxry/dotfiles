return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  -- stylua: ignore
  keys = {
    { "<leader>gpl", "<cmd>Octo pr list<CR>",       desc = "List PRs" },
    { "<leader>gpi", "<cmd>Octo review start<CR>",  desc = "Init PR review" },
    { "<leader>gpr", "<cmd>Octo review resume<CR>", desc = "Resume review" },
    { "<leader>gpc", "<cmd>Octo review close<CR>",  desc = "Close review" },
    { "<leader>gps", "<cmd>Octo review submit<CR>", desc = "Submit review" },
  },
    config = true,
  },
}
