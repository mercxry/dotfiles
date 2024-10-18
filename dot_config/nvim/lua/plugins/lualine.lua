return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
      },
      {
        "SmiteshP/nvim-navic",
        dependencies = {
          "neovim/nvim-lspconfig",
        },
      },
    },
    config = function()
      -- Location with current line and column, and total lines in file
      local function improved_location()
        local r, c = unpack(vim.api.nvim_win_get_cursor(0))
        return string.format("%d:%d | %d", r, c, vim.fn.line "$")
      end

      require("lualine").setup {
        options = {
          theme = vim.g.colors_name,
          globalstatus = true,
        },
        sections = {
          lualine_c = {
            { "filename", file_status = false, path = 1, icons_enabled = true },
            { "navic", color_correction = nil, navic_opts = nil },
          },
          lualine_z = { improved_location },
        },
      }
    end,
  },
}
