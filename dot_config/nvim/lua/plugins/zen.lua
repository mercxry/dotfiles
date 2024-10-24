return {
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
      window = {
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false, -- disable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace characters
        },
      },
      plugins = {
        gitsigns = { enabled = true },
        tmux = { enabled = true },
        todo = { enabled = true },
      },
      on_open = function(win)
        -- hides lualine
        local lualine = package.loaded["lualine"]
        if lualine then
          vim.o.laststatus = 2
          require("lualine").hide()

          if vim.bo.filetype == "markdown" then
            vim.wo.wrap = true
          end
        end
      end,
      on_close = function()
        -- shows lualine
        local lualine = package.loaded["lualine"]
        if lualine then
          vim.o.laststatus = 3
          require("lualine").hide { unhide = true }

          if vim.bo.filetype == "markdown" then
            vim.wo.wrap = false
          end
        end
      end,
    },
  },
  {
    "folke/twilight.nvim",
    opts = {},
  },
}
