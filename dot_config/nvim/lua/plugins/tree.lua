vim.g.nvim_tree_quit_on_open = 1

require'nvim-tree'.setup{}

vim.cmd[[nnoremap <C-n> :NvimTreeToggle<CR>]]

