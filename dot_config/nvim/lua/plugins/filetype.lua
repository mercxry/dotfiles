require("filetype").setup({
    overrides = {
        extensions = {
            tf = "terraform",
        },
        complex = {
            [".*%.conf%.d/.*%.conf"] = "nginx",
        }
    },
})
