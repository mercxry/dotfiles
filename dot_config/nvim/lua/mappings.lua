-- Set leader key (,)
vim.cmd [[let mapleader = ',']]

-- turn off search highlight (,<space>)
vim.cmd [[nnoremap <leader><space> :nohlsearch<CR>]]

-- open/closes folds (<space>)
-- vim.cmd[[nnoremap <space> za]]

-- move vertically by visual line
vim.cmd [[nnoremap j gj]]
vim.cmd [[nnoremap k gk]]

-- highlight last inserted text
vim.cmd [[nnoremap gV `[v`]]

-- reload init.vim
vim.cmd [[nnoremap <leader>R :source %<CR>]]

-- quick split
vim.cmd [[noremap <leader>v :vsp<CR><C-w><C-w>]]

-- puml
vim.api.nvim_create_user_command('PumlRenderSVG', ':!plantuml %:p -tsvg', { nargs = 0 })
vim.api.nvim_set_keymap('n', '<leader>psvg', ':PumlRenderSVG<CR>', { silent = true })

-- open diagnostics
vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd> lua vim.diagnostic.open_float() <CR>', { silent = true })

-- open lazy
vim.api.nvim_set_keymap('n', '<leader>l', ':Lazy<CR>', { silent = true })
