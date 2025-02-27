return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end,
    },
    event = "InsertEnter",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "giuxtaposition/blink-cmp-copilot",
      "disrupted/blink-cmp-conventional-commits",
    },
    version = "*",
    -- https://cmp.saghen.dev/configuration/general.html
    opts = {
      snippets = { preset = "luasnip" },
      keymap = {
        preset = "enter",

        ["<C-e>"] = { "hide", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback_to_mappings" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback_to_mappings" },
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          auto_brackets = {
            force_allow_filetypes = { "rust" },
          },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot", "conventional_commits", "dadbod" },
        providers = {
          cmdline = {
            min_keyword_length = function(ctx)
              -- when typing a command, only show when the keyword is 3 characters or longer
              if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                return 3
              end
              return 0
            end,
          },
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            async = true,
          },
          conventional_commits = {
            name = "Conventional Commits",
            module = "blink-cmp-conventional-commits",
            enabled = function()
              return vim.bo.filetype == "gitcommit"
            end,
            opts = {},
          },
          dadbod = {
            name = "Dadbod",
            module = "vim_dadbod_completion.blink",
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      cmdline = {
        keymap = {
          preset = "enter",

          ["<Tab>"] = { "show", "accept" },
          ["<CR>"] = { "accept_and_enter", "fallback" },
        },
        completion = {
          menu = {
            auto_show = function(_ctx)
              return vim.fn.getcmdtype() == ":"
              -- enable for inputs as well, with:
              -- or vim.fn.getcmdtype() == '@'
            end,
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
