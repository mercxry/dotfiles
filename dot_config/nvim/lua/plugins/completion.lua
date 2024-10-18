return {
  {
    --[[ "hrsh7th/nvim-cmp", ]]
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "onsails/lspkind-nvim",
      "ray-x/cmp-treesitter",
      "andersevenrud/cmp-tmux",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "davidsierradz/cmp-conventionalcommits",
      "saadparwaiz1/cmp_luasnip",
    },
    --[[ Don't enable InsertEnter event, because it fucks with completion ]]
    --[[ This happens when you open a file and the lsp loads before you have a chance to load ]]
    --[[ this plugin by pressing "i" ]]
    --[[ TODO: Find another way to lazy load? or not, this plugin is needed 99% of the time ]]
    --[[ event = "InsertEnter", ]]
    config = function()
      vim.o.completeopt = "menuone,noinsert,noselect"
      -- vim.o.shortmess += 'c'

      local cmp = require "cmp"
      local lspkind = require "lspkind"
      local luasnip = require "luasnip"
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<Up>"] = cmp.mapping.select_prev_item(),
          ["<Down>"] = cmp.mapping.select_next_item(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          },
        },
        formatting = {
          format = lspkind.cmp_format { with_text = true, maxwidth = 50 },
        },

        -- Installed sources
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "vsnip" },
          { name = "path" },
          { name = "buffer", keyword_length = 3 },
          { name = "nvim_lua" },
          { name = "emoji" },
          { name = "tmux", keyword_length = 3 },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp_document_symbol" },
          { name = "luasnip" },
          { name = "orgmode" },
        },

        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
          },
        },

        experimental = {
          native_menu = false,
        },
      }

      cmp.setup.cmdline(":", {
        sources = {
          { name = "cmdline" },
        },
        mapping = cmp.mapping.preset.cmdline {},
      })

      cmp.setup.cmdline("/", {
        sources = {
          { name = "buffer" },
        },
        mapping = cmp.mapping.preset.cmdline {},
      })

      cmp.setup.buffer {
        sources = cmp.config.sources {
          { name = "conventionalcommits" },
          { name = "buffer" },
        },
      }
    end,
  },
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
}
