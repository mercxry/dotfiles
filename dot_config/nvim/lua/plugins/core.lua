return {
    { "airblade/vim-rooter" }, -- Set the working directory to the project root
    { "romainl/vim-cool" },
    { "nvim-neotest/nvim-nio" },
    {
        "nvim-lua/popup.nvim",
        dependencies = "nvim-lua/plenary.nvim"
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
        "nosduco/remote-sshfs.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        opts = {
            connections = {
                sshfs_args = {
                    "-o reconnect",
                    "-o ConnectTimeout=5",
                    "-o defer_permissions"
                }
            },
            ui = {
                confirm = {
                    connect = false,
                },
            },
        },
    },
}
