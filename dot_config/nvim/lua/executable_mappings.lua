-- Set leader key (,)
vim.cmd[[let mapleader = ',']]

-- turn off search highlight (,<space>)
vim.cmd[[nnoremap <leader><space> :nohlsearch<CR>]]

-- open/closes folds (<space>)
vim.cmd[[nnoremap <space> za]]

-- move vertically by visual line
vim.cmd[[nnoremap j gj]]
vim.cmd[[nnoremap k gk]]

-- highlight last inserted text
vim.cmd[[nnoremap gV `[v`]]

-- reload init.vim
vim.cmd[[nnoremap <leader>R :source $MYVIMRC<CR>]]

-- quick split
vim.cmd[[noremap <leader>v :vsp<CR><C-w><C-w>]]
