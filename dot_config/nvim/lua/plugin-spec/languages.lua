return {
    { "editorconfig/editorconfig-vim" },
    { "imsnif/kdl.vim" },
    {
        "NoahTheDuke/vim-just",
        event = "BufRead .justfile"
    },
    {
        "lifepillar/pgsql.vim",
        config = function()
            vim.g.sql_type_default = 'pgsql'
        end
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
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
        init = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            local navic = require("nvim-navic")

            local function on_attach(client, bufnr)
                --  Show navication
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end

                if client.server_capabilities.documentHighlightProvider then
                    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
                end

                vim.keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<leader>a", "<cmd>lua vim.cmd.RustLsp('codeAction')<CR>", { buffer = bufnr })
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
                        ['rust-analyzer'] = {
                            checkOnSave = {
                                command = "clippy",
                                extraArgs = { "--", "-D", "clippy::all" },
                            },

                        },
                    },
                },
            }
        end
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
    --[[ { ]]
    --[[     "iamcco/markdown-preview.nvim", ]]
    --[[     build = function() vim.fn["mkdp#util#install"]() end, ]]
    --[[ }, ]]
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
        dependencies = "tyru/open-browser.vim"
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
                    "@styled/typescript-styled-plugin"
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
        opts = {}
    },
}
