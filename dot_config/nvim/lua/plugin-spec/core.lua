return {
    { "airblade/vim-rooter" }, -- Set the working directory to the project root
    { "romainl/vim-cool" },
    {
        "nvim-lua/popup.nvim",
        dependencies = "nvim-lua/plenary.nvim"
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.dashboard").config)
        end,
    },
    {
        "stevearc/dressing.nvim",
        config = true
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },
    {
        "junegunn/fzf",
        build = function()
            vim.fn["fzf#install"]()
        end
    },
    {
        "voldikss/vim-floaterm",
        keys = {
            {
                "<F7>",
                function()
                    vim.cmd [[FloatermNew]]
                end
            },
            {
                "<F12>",
                function()
                    vim.cmd [[FloatermToggle]]
                end
            },
        },
    },
    {
        "nathom/filetype.nvim",
        opts = {
            overrides = {
                extensions = {
                    tf = "terraform",
                    astro = "astro",
                    sql = "pgsql",
                },
                complex = {
                    [".*%.conf%.d/.*%.conf"] = "nginx",
                    [".*justfile.*"] = "just",
                }
            },
        },
    },
}
