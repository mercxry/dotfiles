return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "famiu/bufdelete.nvim" },
    event = {
      "BufAdd",
      "BufRead",
    },
    opts = {
      options = {
        numbers = function(opts)
          return string.format("%s.", opts.ordinal)
        end,
        diagnostics = "nvim-lsp",
        show_close_icon = false,
      },
    },
    keys = {
      { "<TAB>", "<cmd>BufferLineCycleNext<CR>", desc = "Switch to next buffer" },
      { "<A-TAB>", "<cmd>BufferLineCyclePrev<CR>", desc = "Switch to previous buffer" },
      { "<A-w>", "<cmd>bdelete<CR>", desc = "Delete current buffer" },
      { "<A-W>", "<cmd>bdelete!<CR>", desc = "Force delete current buffer" },
      { "<A-0>", "<cmd>BufferLinePick<CR>", desc = "Pick a buffer" },
      { "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
      { "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
      { "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
      { "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
      { "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
      { "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
      { "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
      { "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
      { "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },
    },
  },
}
