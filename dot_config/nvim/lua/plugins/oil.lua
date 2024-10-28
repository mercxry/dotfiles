return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
      { "<leader>E", "<cmd>Oil --float<cr>", desc = "Opens Oil in a float" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = false,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
    },
  },
}
