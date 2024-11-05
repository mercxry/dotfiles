return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    --[[ event = { "BufReadPost", "BufNewFile" }, ]]
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = "all",
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        ignore_install = { "org", "phpdoc", "tree-sitter-phpdoc" },
        -- indent = {
        --   enable = true
        -- }
      }
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      -- Skip backwards compatibility routines and speed up loading.
      vim.g.skip_ts_context_commentstring_module = true

      require("ts_context_commentstring").setup {
        enable_autocmd = false,
      }
    end,
  },
}
