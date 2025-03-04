return {
  require "plugins.lsp.lsp-config",
  require "plugins.lsp.nonels",
  require "plugins.lsp.mason",

  { "liuchengxu/vista.vim" }, -- LSP symbol and tags viewer
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end,
  },
}
