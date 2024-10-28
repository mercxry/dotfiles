return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        lazy = true,
      },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<leader>DD", "<cmd>DBUIToggle<cr>", desc = "Open UI" },
      { "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "Add connection" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find buffer" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
