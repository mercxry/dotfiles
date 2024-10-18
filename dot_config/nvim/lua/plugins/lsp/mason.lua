return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    keys = {
      { "<leader>M", "<cmd>Mason<CR>", desc = "Mason" },
    },
    config = function()
      --[[ local masonServers = require "plugin-config.lsp" ]]
      require("mason").setup()
      require("mason-lspconfig").setup {
        --[[ ensure_installed = masonServers, ]]
        automatic_installation = true,
      }
    end,
  },
}
