return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark" -- Force dark background

      vim.cmd.colorscheme "kanagawa"
    end,
  },
}
