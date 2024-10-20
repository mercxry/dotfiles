return {
  { "christoomey/vim-tmux-navigator" }, -- Tmux navigator integration
  { "mfussenegger/nvim-overfly" },
  {
    "karb94/neoscroll.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local opts = {
        mappings = {
          "<C-u>",
          "<C-d>",
        },
      }
      require("neoscroll").setup(opts)
    end,
  },
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  },
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup {}
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end,
  },
  {
    "kylechui/nvim-surround",
    config = true,
  },
  {
    "mbbill/undotree",
    -- stylua: ignore
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo tree", },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "anuvyklack/fold-preview.nvim",
    dependencies = "anuvyklack/keymap-amend.nvim",
    config = function()
      require("fold-preview").setup()
    end,
  },
  {
    "windwp/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Spectre (search and replace)", },
    },
    config = true,
  },
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup {
        highlight_on_key = true,
      }
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("statuscol").setup()
    end,
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
  {
    "smilhey/ed-cmd.nvim",
    config = function()
      require("ed-cmd").setup {}
    end,
  },
}
