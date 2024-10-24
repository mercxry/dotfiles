return {
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gdd", "<cmd>DiffviewToggle<CR>", desc = "Diff toggle" },
      { "<leader>gdm", "<cmd>DiffviewOpen origin/main...HEAD --imply-local<CR>", desc = "Diff origin/main..HEAD" },
    },
    config = function()
      vim.api.nvim_create_user_command("DiffviewToggle", function(e)
        local view = require("diffview.lib").get_current_view()

        if view then
          vim.cmd "DiffviewClose"
        else
          vim.cmd("DiffviewOpen " .. e.args)
        end
      end, { nargs = "*" })
    end,
  },
}
