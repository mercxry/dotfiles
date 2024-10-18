return {
  { "liuchengxu/vista.vim" }, -- LSP symbol and tags viewer
  {
    "neovim/nvim-lspconfig",
    -- dependencies = { "nvim-lua/lsp-status.nvim" },
    keys = {
      { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
      { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
      { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
      { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" } },
      { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" } },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
    },
    config = function()
      -- local lsp_status = require("lsp-status")
      local lspconfig = require "lspconfig"
      local navic = require "nvim-navic"

      -- lsp_status.register_progress()

      -- Open diagnostic when on line
      --[[ vim.diagnostic.config({ virtual_text = false }) ]]
      --[[ vim.api.nvim_create_autocmd("CursorHold", { ]]
      --[[     callback = function() ]]
      --[[         vim.diagnostic.open_float(nil, { ]]
      --[[             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" }, ]]
      --[[             focusable = false, ]]
      --[[             source = 'always', ]]
      --[[             prefix = ' - ', ]]
      --[[         }) ]]
      --[[     end ]]
      --[[ }) ]]

      local function on_attach(client, bufnr)
        --  Show navication
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end

        if client.server_capabilities.documentHighlightProvider then
          vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.format()"
        end

        -- lsp_status.on_attach(client)

        -- vim.notify("[" .. client.name .. "] " .. "Language Server Protocol started")
      end

      local function on_attach_no_fmt(client, bufnr)
        --  Show navication
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end

        client.server_capabilities.document_formatting = false

        -- lsp_status.on_attach(client)
      end

      -- Setup capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

      function filterMasonServers(servers)
        local masonServers = {}
        for _, server in ipairs(servers) do
          if server.install then
            table.insert(masonServers, server.name)
          end
        end

        return masonServers
      end

      -- Language servers
      -- Debug with print(vim.inspect(vim.lsp.get_active_clients()))
      local servers = {
        { name = "astro", install = true },
        { name = "bashls", install = true },
        { name = "clangd", install = true },
        { name = "csharp_ls", install = true },
        { name = "dhall_lsp_server", install = true },
        { name = "docker_compose_language_service", install = true },
        { name = "dockerls", install = true },
        { name = "elixirls", install = true },
        { name = "emmet_ls", install = true },
        { name = "eslint", install = true },
        { name = "gleam", install = false },
        { name = "gopls", install = true },
        { name = "graphql", install = true },
        { name = "helm_ls", install = true },
        { name = "hls", install = true },
        { name = "html", install = true },
        { name = "jsonls", install = true },
        { name = "jsonnet_ls", install = true },
        { name = "lua_ls", install = true },
        { name = "marksman", install = true },
        { name = "mdx_analyzer", install = true },
        { name = "ocamllsp", install = true },
        { name = "prismals", install = true },
        { name = "pyright", install = true },
        { name = "ruby_lsp", install = true },
        { name = "ruff_lsp", install = true },
        { name = "svelte", install = true },
        { name = "tailwindcss", install = true },
        { name = "terraformls", install = true },
        { name = "texlab", install = true },
        { name = "tflint", install = true },
        { name = "ts_ls", install = true },
        { name = "volar", install = true },
        { name = "yamlls", install = true },
      }

      local masonServers = filterMasonServers(servers)

      -- User configurations for individual servers
      local configs = {
        elixirls = {
          cmd = { "/usr/local/bin/elixir-ls/language_server.sh" },
        },
        hls = {
          filetypes = { "haskell", "lhaskell", "cabal" },
        },
        lua_ls = {
          settings = {
            Lua = {
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                },
              },
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        --[[ astro = { ]]
        --[[     init_options = { ]]
        --[[         typescript = vim.fn.stdpath('data') .. "/mason/bin/typescript-language-server" ]]
        --[[     } ]]
        --[[ } ]]
      }

      -- User configurations for all servers
      local config_defaults = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- Setup configurations
      for _, lsp in ipairs(servers) do
        local config = configs[lsp.name] or {}
        config = vim.tbl_extend("keep", config, config_defaults)
        lspconfig[lsp.name].setup(config)
      end

      -- Change diagnostic signs.
      local signs = { Error = "󰅚 ", Warn = " ", Hint = "󰌶 ", Info = " " }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Global config for diagnostic
      vim.diagnostic.config {
        underline = false,
        signs = true,
        severity_sort = true,
      }

      -- lsp_status.config({
      --     indicator_errors = 'E',
      --     indicator_warnings = 'W',
      --     indicator_info = 'i',
      --     indicator_hint = '?',
      --     indicator_ok = 'Ok',
      -- })

      return masonServers
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    keys = {
      { "<leader>M", "<cmd>Mason<CR>", desc = "Mason" },
    },
    config = function()
      --[[ local masonServers = require "plugin-config.lsp" ]]
      require("mason").setup()
      require("mason-lspconfig").setup {
        --[[ ensure_installed = masonServers, ]]
        automatic_installation = true,
      }
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols (Trouble)" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>",                      desc = "LSP references/definitions/... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local null_ls = require "null-ls"

      null_ls.setup {
        sources = {
          -- Python
          --[[ null_ls.builtins.formatting.black, ]]

          -- Lua
          null_ls.builtins.formatting.stylua,

          -- Shell
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.shellharden,
          --[[ null_ls.builtins.diagnostics.shellcheck, ]]
          --[[ null_ls.builtins.code_actions.shellcheck, ]]

          -- CSS
          null_ls.builtins.formatting.stylelint,
          null_ls.builtins.diagnostics.stylelint,

          -- C/C++
          -- null_ls.builtins.formatting.uncrustify, -- Java and C# too
          null_ls.builtins.diagnostics.cppcheck,

          -- Others
          -- null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.prettier.with {
            extra_filetypes = { "astro" },
          },
          null_ls.builtins.formatting.nginx_beautifier,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.diagnostics.hadolint, -- Dockerfiles
          null_ls.builtins.diagnostics.yamllint.with {
            extra_args = { "-d", os.getenv "HOME" .. "/.config/nvim/.yamllint.yaml" },
          },
          null_ls.builtins.formatting.golines, -- Includes gofmt and goimports
          null_ls.builtins.formatting.mix, -- Elixir
          --[[ null_ls.builtins.diagnostics.vale, ]]
        },
        on_attach = function(client, bufnr)
          if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { async = false }
              end,
            })
          end
        end,
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = function()
      require("fidget").setup {}
    end,
  },
  --[[ { ]]
  --[[     "aznhe21/actions-preview.nvim", ]]
  --[[     opts = { ]]
  --[[         diff = { ]]
  --[[             indent_heuristic = true, ]]
  --[[         } ]]
  --[[     }, ]]
  --[[     keys = { ]]
  --[[         { ]]
  --[[             "ca", ]]
  --[[             mode = { "v", "n" }, ]]
  --[[             function() ]]
  --[[                 require("actions-preview").code_actions() ]]
  --[[             end, ]]
  --[[             desc = "Code Actions", ]]
  --[[         }, ]]
  --[[     }, ]]
  --[[ } ]]
}
