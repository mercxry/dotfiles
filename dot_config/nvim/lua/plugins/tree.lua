-- vim.g.actions.open_file.quit_on_open = 1

require'nvim-tree'.setup{
    actions = {
        open_file = {
            quit_on_open = 1
        }
    }
}

vim.cmd[[nnoremap <C-n> :NvimTreeToggle<CR>]]

