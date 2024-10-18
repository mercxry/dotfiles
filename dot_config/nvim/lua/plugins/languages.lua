return {
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

  -- Rust
  --[[ { ]]
  --[[     "simrat39/rust-tools.nvim", ]]
  --[[     dependencies = "neovim/nvim-lspconfig", ]]
  --[[     ft = "rust", ]]
  --[[     config = function() ]]
  --[[         local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()) ]]
  --[[]]
  --[[         local rt = require("rust-tools") ]]
  --[[         local mason_registry = require("mason-registry") ]]
  --[[]]
  --[[         local codelldb = mason_registry.get_package("codelldb") ]]
  --[[         local extension_path = codelldb:get_install_path() .. "/extension/" ]]
  --[[         local codelldb_path = extension_path .. "adapter/codelldb" ]]
  --[[         local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib" ]]
  --[[]]
  --[[         local navic = require("nvim-navic") ]]
  --[[         local function on_attach(client, bufnr) ]]
  --[[             --  Show navication ]]
  --[[             if client.server_capabilities.documentSymbolProvider then ]]
  --[[                 navic.attach(client, bufnr) ]]
  --[[             end ]]
  --[[]]
  --[[             if client.server_capabilities.documentHighlightProvider then ]]
  --[[                 vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()") ]]
  --[[             end ]]
  --[[]]
  --[[             vim.keymap.set("n", "<leader>k", rt.hover_actions.hover_actions, { buffer = bufnr }) ]]
  --[[             vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr }) ]]
  --[[         end ]]
  --[[]]
  --[[         rt.setup({ ]]
  --[[             server = { ]]
  --[[                 on_attach = on_attach, ]]
  --[[                 capabilities = capabilities, ]]
  --[[                 settings = { ]]
  --[[                     ["rust-analyzer"] = { ]]
  --[[                         checkOnSave = { ]]
  --[[                             command = "clippy", ]]
  --[[                             extraArgs = { "--", "-D", "clippy::all" }, ]]
  --[[                         }, ]]
  --[[                     }, ]]
  --[[                 }, ]]
  --[[             }, ]]
  --[[             dap = { ]]
  --[[                 adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path) ]]
  --[[             } ]]
  --[[         }) ]]
  --[[]]
  --[[         local opts = { noremap = true, silent = true } ]]
  --[[         vim.api.nvim_set_keymap('n', '<leader>grd', '<cmd>RustOpenExternalDocs<CR>', opts) ]]
  --[[     end, ]]
  --[[ }, ]]
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    init = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local navic = require "nvim-navic"

      local function on_attach(client, bufnr)
        --  Show navication
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end

        if client.server_capabilities.documentHighlightProvider then
          vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.format()"
        end

        vim.keymap.set(
          "n",
          "<leader>co",
          "<cmd>lua vim.cmd.RustLsp('openDocs')<CR>",
          { buffer = bufnr, desc = "Open Rust docs" }
        )
      end

      vim.g.rustaceanvim = {
        --[[ tools = { ]]
        --[[     -- ... ]]
        --[[ }, ]]
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--", "-D", "clippy::all" },
              },
            },
          },
        },
      }
    end,
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },

  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    keys = { { "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" } },
    --[[ build = "cd app && npm install", ]]
    build = function(plugin)
      if vim.fn.executable "npx" then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd [[Lazy load markdown-preview.nvim]]
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      vim.cmd [[
                function OpenMarkdownPreview(url)
                    exec "silent !open -a Min -n --args --new-window " . a:url
                endfunction
            ]]

      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    end,
    config = function()
      vim.g.mkdp_auto_close = false
      vim.g.mkdp_combine_preview = true
      vim.g.mkdp_echo_preview_url = true
      vim.g.mkdp_page_title = "${name}"
      vim.g.mkdp_port = 8007
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  },
  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown",
    init = function()
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = "*.md",
        command = "MDResetListNumbering",
      })
    end,
    opts = {
      on_attach = function(bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr }
        map({ "n", "i" }, "<M-l><M-o>", "<Cmd>MDListItemBelow<CR>", opts)
        map({ "n", "i" }, "<M-L><M-O>", "<Cmd>MDListItemAbove<CR>", opts)
        map("n", "<M-c>", "<Cmd>MDTaskToggle<CR>", opts)
        map("x", "<M-c>", ":MDTaskToggle<CR>", opts)
      end,
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      --[[ { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" }, ]]
    },
  },
  {
    "3rd/image.nvim",
    config = function() end,
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      -- refer to `configuration to change defaults`
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
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
