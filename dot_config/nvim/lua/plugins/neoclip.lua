return {
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { "kkharji/sqlite.lua" },
      { "nvim-telescope/telescope.nvim" },
    },
    opts = {
      enable_persistent_history = true,
    },
  -- stylua: ignore
  keys = {
    { "<leader>sp", function() require("telescope").extensions.neoclip.default() end,    desc = "Pasteboard history", },
    { "<leader>sM", function() require("telescope").extensions.macroscope.default() end, desc = "Macros", },
  },
  },
}
