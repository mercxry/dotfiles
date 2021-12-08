local M = {}

M.project_files = function()
  local opts = {}
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

require("telescope").setup({
	defaults = { file_ignore_patterns = { "node_modules", "^.git/" } },
	pickers = {
		find_files = {
			hidden = true,
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
		},
		git_files = {
			hidden = true,
		},
	},
})

require("telescope").load_extension("fzf")

-- Search filename (ctrl+p)
vim.cmd([[nnoremap <C-p> <cmd>lua require'plugins.telescope'.project_files()<CR>]])
vim.cmd([[nnoremap <leader>/ <cmd>Telescope live_grep<CR>]])
vim.cmd([[nnoremap <leader>fb <cmd>Telescope buffers<CR>]])

return M
