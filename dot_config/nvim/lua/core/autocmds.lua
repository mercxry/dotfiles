-- Set relative numbers in normal mode but not in insert mode
if not vim.g.vscode then
  vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
      vim.opt.relativenumber = false
    end,
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
      vim.opt.relativenumber = true
    end,
  })
end

-- Don't continue comments when pressing "o" to create a new line
local autoGroup = vim.api.nvim_create_augroup("autoGroup", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = autoGroup,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "c" - "r" - "o"
  end,
})

-- set tab width to 2 for lua files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

-- vim.cmd([[
--     augroup CLOSE_IF_LAST_BUFFER
--         autocmd!
--         autocmd BufDelete * silent! if len(getbufinfo({'buflisted':1})) == 0 | q | endif
--     augroup END
-- ]])

-- Close quickfix menu after selecting choice
--[[ vim.api.nvim_create_autocmd( ]]
--[[     "FileType", { ]]
--[[         pattern = { "qf" }, ]]
--[[         command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
--[[     }) ]]
