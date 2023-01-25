return {
    { "rafamadriz/friendly-snippets" },
    {
        "hrsh7th/nvim-cmp",
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
        config = function()
            require("plugin-config.cmp")
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },
}
