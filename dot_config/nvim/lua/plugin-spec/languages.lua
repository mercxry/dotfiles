return {
    { "editorconfig/editorconfig-vim" },
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
        config = function()
            local function on_attach(client, bufnr)
                if client.server_capabilities.documentHighlightProvider then
                    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
                end
            end

            require("rust-tools").setup({
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
}
