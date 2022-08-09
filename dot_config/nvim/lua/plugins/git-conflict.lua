require("git-conflict").setup({
    default_mappings = false,
})

vim.keymap.set('n', '<leader>gcc', '<Plug>(git-conflict-ours)')
vim.keymap.set('n', '<leader>gci', '<Plug>(git-conflict-theirs)')
vim.keymap.set('n', '<leader>gcb', '<Plug>(git-conflict-both)')
vim.keymap.set('n', '<leader>gc0', '<Plug>(git-conflict-none)')
vim.keymap.set('n', '<leader>gcp', '<Plug>(git-conflict-prev-conflict)')
vim.keymap.set('n', '<leader>gcn', '<Plug>(git-conflict-next-conflict)')
