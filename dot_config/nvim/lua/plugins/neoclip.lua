require('neoclip').setup(
    {
        enable_persistent_history = true,
    }
)

vim.api.nvim_set_keymap("n", "<leader>pb", "<cmd>lua require('telescope').extensions.neoclip.default()<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>mb", "<cmd>lua require('telescope').extensions.macroscope.default()<CR>",
    { noremap = true, silent = true })
