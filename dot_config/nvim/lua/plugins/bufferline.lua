require("bufferline").setup {
    options = {
        numbers = function(opts)
            return string.format('%s.', opts.ordinal)
        end,
        diagnostics = 'nvim-lsp',
        show_close_icon = false,
    }
}

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<TAB>', '<cmd>BufferLineCycleNext<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-TAB>', '<cmd>BufferLineCyclePrev<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-w>', '<cmd>bdelete<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-W>', '<cmd>bdelete!<CR>', opts)

vim.api.nvim_set_keymap('n', '<A-0>', '<cmd>BufferLinePick<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-1>', '<cmd>BufferLineGoToBuffer 1<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-2>', '<cmd>BufferLineGoToBuffer 2<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-3>', '<cmd>BufferLineGoToBuffer 3<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-4>', '<cmd>BufferLineGoToBuffer 4<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-5>', '<cmd>BufferLineGoToBuffer 5<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-6>', '<cmd>BufferLineGoToBuffer 6<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-7>', '<cmd>BufferLineGoToBuffer 7<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-8>', '<cmd>BufferLineGoToBuffer 8<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-9>', '<cmd>BufferLineGoToBuffer 9<CR>', opts)
