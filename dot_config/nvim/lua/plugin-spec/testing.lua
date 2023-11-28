return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "rouge8/neotest-rust",
            "nvim-neotest/neotest-go",
        },
        opts = {
            adapters = {
                require("neotest-rust") {
                    args = { "--no-capture" },
                },
                require("neotest-go"),
            }
        }
    }
}
