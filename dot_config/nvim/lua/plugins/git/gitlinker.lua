return {
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>gy", mode = "n", function() require("gitlinker").get_buf_range_url("n", {}) end, desc = "Copy git link", },
    { "<leader>gy", mode = "v", function() require("gitlinker").get_buf_range_url("v", {}) end, desc = "Copy git link (Visual mode)", },
    {
      "<leader>gb",
      mode = "n",
      function()
        require("gitlinker").get_buf_range_url("n",
          { action_callback = require("gitlinker.actions").open_in_browser })
      end,
      desc = "Open git link in browser",
    },
    {
      "<leader>gb",
      mode = "v",
      function()
        require("gitlinker").get_buf_range_url("v",
          { action_callback = require("gitlinker.actions").open_in_browser })
      end,
      desc = "Open git link in browser (Visual mode)",
    },
  },
    config = function()
      require("gitlinker").setup()
    end,
  },
}
