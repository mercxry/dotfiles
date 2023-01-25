return {
    { "dstein64/vim-startuptime" },
    { "airblade/vim-rooter" }, -- Set the working directory to the project root
    { "antoinemadec/FixCursorHold.nvim" },
    { "romainl/vim-cool" },
    {
        "nvim-lua/popup.nvim",
        dependencies = "nvim-lua/plenary.nvim"
    },
    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup()
        end,
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.dashboard").config)
        end,
    },
    {
        "stevearc/dressing.nvim",
        config = function()
            require("dressing").setup()
        end
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },
    { "junegunn/fzf", build = function()
        vim.fn["fzf#install"]()
    end
    },
    {
        "voldikss/vim-floaterm",
        config = function()
            vim.api.nvim_set_keymap("n", "<F7>", ":FloatermNew<CR>", { silent = true })
            -- vim.api.nvim_set_keymap("n", "<F8>", ":FloatermPrev<CR>", { silent = true })
            -- vim.api.nvim_set_keymap("n", "<F9>", ":FloatermNext<CR>", { silent = true })
            vim.api.nvim_set_keymap("n", "<F12>", ":FloatermToggle<CR>", { silent = true })
        end
    },
    {
        "nathom/filetype.nvim",
        config = function()
            require("filetype").setup({
                overrides = {
                    extensions = {
                        tf = "terraform",
                        astro = "astro",
                    },
                    complex = {
                        [".*%.conf%.d/.*%.conf"] = "nginx",
                        [".*justfile.*"] = "just",
                    }
                },
            })
        end
    },
}
