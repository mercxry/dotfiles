return {
  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    -- stylua: ignore
    keys = {
      { "<leader>ci", "<Esc><cmd>CodeSnap<cr>",     mode = "x", desc = "Save selected code snapshot into clipboard" },
      { "<leader>cI", "<Esc><cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
    },
    opts = {
      mac_window_bar = false,
      watermark = "",
      has_breadcrumbs = true,
      has_line_number = true,
      show_workspace = true,
      min_width = 0,
      bg_x_padding = 0,
      bg_y_padding = 0,
      save_path = os.getenv "HOME" .. "/Pictures/code-screenshots",
    },
  },
}
