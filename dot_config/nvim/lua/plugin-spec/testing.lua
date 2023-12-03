return {
    {
        "nvim-neotest/neotest",
        keys = { "<leader>n" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "rouge8/neotest-rust",
            "nvim-neotest/neotest-go",
        },
        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
                    require("neotest-rust") {
                        args = { "--no-capture" },
                    },
                    require("neotest-go"),
                }
            })
        end,
    }
}
