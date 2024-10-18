-- move vertically by visual line so that if the line is wrapped it can still be navigated
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true, silent = true })

-- splits
vim.api.nvim_set_keymap(
  "n",
  "<leader>|",
  ":vsp<CR>",
  { noremap = true, silent = true, desc = "Vertical Split (Window)" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>-",
  ":sp<CR>",
  { noremap = true, silent = true, desc = "Horizontal Split (Window)" }
)

-- puml
vim.api.nvim_create_user_command("PumlRenderSVG", ":!plantuml %:p -tsvg", { nargs = 0 })
vim.api.nvim_set_keymap("n", "<leader>psvg", ":PumlRenderSVG<CR>", { silent = true, desc = "Render PlantUML SVG" })

-- open diagnostic float
vim.api.nvim_set_keymap(
  "n",
  "<leader>cd",
  "<cmd>lua vim.diagnostic.open_float()<CR>",
  { silent = true, desc = "Line Diagnostics" }
)

-- open lazy
vim.api.nvim_set_keymap("n", "<leader>L", "<cmd>Lazy<cr>", { silent = true, desc = "Lazy" })

-- map <Esc> to exit terminal mode in Neovim
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- command misstypings
local command_mappings = {
  W = "w",
  Q = "q",
  WQ = "wq",
  Wq = "wq",
  wQ = "wq",
  WA = "wa",
  Wa = "wa",
  QA = "qa",
  Qa = "qa",
}

for uppercase, lowercase in pairs(command_mappings) do
  vim.cmd(string.format("cabbrev %s %s", uppercase, lowercase))
  vim.cmd(string.format("cabbrev %s! %s!", uppercase, lowercase))
end
