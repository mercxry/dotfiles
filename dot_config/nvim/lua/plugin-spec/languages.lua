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
    {
        "simrat39/rust-tools.nvim",
        dependencies = "neovim/nvim-lspconfig",
        ft = "rust",
        config = function()
            --[[ local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.6.7/' ]]
            --[[ local codelldb_path = extension_path .. 'adapter/codelldb' ]]
            --[[ local liblldb_path = extension_path .. 'lldb/lib/liblldb' ]]
            --[[ local this_os = vim.loop.os_uname().sysname; ]]
            --[[]]
            --[[ -- The liblldb extension is .so for linux and .dylib for macOS ]]
            --[[ liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib") ]]
            local rt = require("rust-tools")
            local mason_registry = require("mason-registry")

            local codelldb = mason_registry.get_package("codelldb")
            local extension_path = codelldb:get_install_path() .. "/extension/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

            local navic = require("nvim-navic")
            local function on_attach(client, bufnr)
                --  Shwo navication
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end

                if client.server_capabilities.documentHighlightProvider then
                    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
                end

                vim.keymap.set("n", "<leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
                vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
            end

            rt.setup({
                server = {
                    on_attach = on_attach,
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = {
                                command = "clippy",
                                extraArgs = { "--", "-D", "clippy::all" },
                            },
                        },
                    },
                },
                dap = {
                    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
                }
            })

            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap('n', '<leader>grd', '<cmd>RustOpenExternalDocs<CR>', opts)
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
        build = function() vim.fn["mkdp#util#install"]() end,
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
        ft = "typescript",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {
            settings = {
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
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
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
