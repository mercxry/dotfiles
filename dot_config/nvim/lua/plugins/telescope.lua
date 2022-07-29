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

vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>/", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", {noremap = true, silent = true})

return M
