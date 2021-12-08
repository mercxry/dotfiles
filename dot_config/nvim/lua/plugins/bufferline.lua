vim.opt.termguicolors = true

require("bufferline").setup{
    options = {
        numbers = function(opts)
            return string.format('%s.', opts.ordinal)
        end,
        diagnostics = 'nvim-lsp',
        show_buffer_close_icons = false,
        show_close_icon = false,
    }
}

-- Switch buffers
vim.cmd([[nnoremap <silent><leader>0 :BufferLinePick<CR>]])
vim.cmd([[nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>]])
vim.cmd([[nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>]])
vim.cmd([[nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>]])
vim.cmd([[nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>]])
vim.cmd([[nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>]])
vim.cmd([[nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>]])
vim.cmd([[nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>]])
vim.cmd([[nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>]])
vim.cmd([[nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>]])

-- Delete buffers
function delbuf(num)
  require('bufferline').buf_exec(num, function(buf, visible_buffers)
      -- vim.cmd('bdelete '..buf.id)
      require('bufdelete').bufdelete(buf.id)
  end)
end

vim.cmd([[nnoremap <silent><leader>d0 :BufferLinePickClose<CR>]])
vim.cmd([[nnoremap <silent><leader>d1 <Cmd>lua delbuf(1)<CR>]])
vim.cmd([[nnoremap <silent><leader>d2 <Cmd>lua delbuf(2)<CR>]])
vim.cmd([[nnoremap <silent><leader>d3 <Cmd>lua delbuf(3)<CR>]])
vim.cmd([[nnoremap <silent><leader>d4 <Cmd>lua delbuf(4)<CR>]])
vim.cmd([[nnoremap <silent><leader>d5 <Cmd>lua delbuf(5)<CR>]])
vim.cmd([[nnoremap <silent><leader>d6 <Cmd>lua delbuf(6)<CR>]])
vim.cmd([[nnoremap <silent><leader>d7 <Cmd>lua delbuf(7)<CR>]])
vim.cmd([[nnoremap <silent><leader>d8 <Cmd>lua delbuf(8)<CR>]])
vim.cmd([[nnoremap <silent><leader>d9 <Cmd>lua delbuf(9)<CR>]])

