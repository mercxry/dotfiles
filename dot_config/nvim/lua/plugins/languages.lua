return {
  require "plugins.languages.rust",
  require "plugins.languages.markdown",

  { "editorconfig/editorconfig-vim" },
  { "imsnif/kdl.vim" },
  { "jidn/vim-dbml" },
  {
    "NoahTheDuke/vim-just",
    event = "BufRead .justfile",
  },
  {
    "lifepillar/pgsql.vim",
    config = function()
      vim.g.sql_type_default = "pgsql"
    end,
  },

  -- PlantUML
  { "aklt/plantuml-syntax" },
  {
    "weirongxu/plantuml-previewer.vim",
    dependencies = "tyru/open-browser.vim",
  },

  -- Typescript
  {
    "pmizio/typescript-tools.nvim",
    cond = false,
    --[[ ft = "typescript", ]]
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        --[[ tsserver_path = vim.fn.stdpath('data') .. "/mason/bin/typescript-language-server", ]]
        tsserver_plugins = {
          "@styled/typescript-styled-plugin",
        },
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = "typescript",
    config = true,
  },

  -- Lua
  {
    "folke/neodev.nvim",
    ft = "lua",
    opts = {},
  },
}
