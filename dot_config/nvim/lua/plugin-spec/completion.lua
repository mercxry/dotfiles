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
            require("plugin-config.cmp")
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
            end
        },
        event = "InsertEnter",
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        }
    },
}
