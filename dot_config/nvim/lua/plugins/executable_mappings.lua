-- Toggle undo tree
vim.cmd([[nnoremap <leader>u :UndotreeShow<CR>]])

-- Project search
vim.cmd([[nnoremap <leader>/ :Rg<CR>]])

-- Vim Fugitive
vim.cmd([[nmap <leader>gst :G<CR>]])
vim.cmd([[nmap <leader>gc :Gcommit<CR>]])
vim.cmd([[nmap <leader>gbc :BCommits<CR>]])
vim.cmd([[nmap <leader>gbw :Gbrowse<CR>]])
vim.cmd([[nmap <leader>gl :Glog<CR>]])
vim.cmd([[nmap <leader>gff :GFiles<CR>]])
vim.cmd([[nmap <leader>gpl :Gpull<CR>]])
vim.cmd([[nmap <leader>gps :Gpush<CR>]])
vim.cmd([[nmap <leader>gf :diffget //2<CR>]])
vim.cmd([[nmap <leader>gj :diffget //3<CR>]])

