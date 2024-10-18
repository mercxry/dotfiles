return {
  require "plugins.git.gitsigns",
  require "plugins.git.diffview",
  require "plugins.git.gitconflict",
  require "plugins.git.gitlinker",
  require "plugins.git.octo",

  { "tpope/vim-fugitive" }, -- It should be illegal
  { "tpope/vim-rhubarb" }, -- Github support
  { "junegunn/gv.vim" }, -- Commit Browser
  { "APZelos/blamer.nvim" }, -- Blame line
}
