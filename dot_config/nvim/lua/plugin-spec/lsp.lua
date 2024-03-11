return {
    { "liuchengxu/vista.vim" }, -- LSP symbol and tags viewer
    {
        "neovim/nvim-lspconfig",
        -- dependencies = { "nvim-lua/lsp-status.nvim" },
        config = function()
            require("plugin-config.lsp")
        end,
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local servers = require("plugin-config.lsp")
            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = servers,
                automatic_installation = true,
            }
        end,
        keys = {
            {
                "<leader>vm",
                function()
                    vim.cmd [[Mason]]
                end
            }
        }
    },
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        opts = {},
        keys = {
            {
                "<leader>tr",
                function()
                    vim.cmd [[TroubleToggle]]
                end
            }
        }
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    -- Python
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.diagnostics.pylama,
                    null_ls.builtins.formatting.reorder_python_imports,

                    -- Shell
                    null_ls.builtins.formatting.shfmt,
                    null_ls.builtins.formatting.shellharden,
                    null_ls.builtins.diagnostics.shellcheck,
                    null_ls.builtins.code_actions.shellcheck,

                    -- CSS
                    null_ls.builtins.formatting.stylelint,
                    null_ls.builtins.diagnostics.stylelint,

                    -- C/C++
                    -- null_ls.builtins.formatting.uncrustify, -- Java and C# too
                    null_ls.builtins.diagnostics.cppcheck,

                    -- Others
                    -- null_ls.builtins.formatting.rustfmt,
                    -- null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.nginx_beautifier,
                    -- null_ls.builtins.formatting.terraform_fmt,
                    null_ls.builtins.diagnostics.hadolint, -- Dockerfiles
                    null_ls.builtins.diagnostics.yamllint.with({
                        extra_args = { "-d", os.getenv("HOME") .. "/.config/nvim/.yamllint.yaml" }
                    }),
                    null_ls.builtins.formatting.golines, -- Includes gofmt and goimports
                    null_ls.builtins.formatting.mix,     -- Elixir
                    --[[ null_ls.builtins.diagnostics.vale, ]]
                },
            })
        end
    },
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = function()
            require("fidget").setup({})
        end
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
