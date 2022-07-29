require('spectre').setup()

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>S', '<cmd>lua require(\'spectre\').open()<CR>', opts)
