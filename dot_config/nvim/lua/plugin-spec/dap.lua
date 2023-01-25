return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("plugin-spec.dap")
        end
    },
    { 'nvim-telescope/telescope-dap.nvim' },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()
        end
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter"
        },
        config = function()
            require("nvim-dap-virtual-text").setup({})
        end
    },
    {
        "jayp0521/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap"
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "codelldb" }
            })
        end
    },

}
