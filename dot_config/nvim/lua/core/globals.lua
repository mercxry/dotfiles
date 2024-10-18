vim.g.mapleader = ","
vim.g.localleader = ","

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2

-- Indents
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smarttab = true -- Delete spaces based on tabstop
vim.opt.autoindent = true
vim.opt.tabstop = 4 -- tab creates 4 spaces
vim.opt.shiftwidth = 4 -- tab creates 4 spaces

-- Better Search
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- if there are uppercase letters, it becomes case-sensitive
vim.opt.incsearch = true -- live incremental searching
vim.opt.hlsearch = true -- highlight matches
vim.opt.gdefault = true -- use the `g` flag by default.

-- Folding
vim.opt.foldenable = true -- enable folding
vim.opt.foldlevelstart = 10 -- open most folds by default
vim.opt.foldnestmax = 10 -- 10 nested fold max
vim.opt.foldmethod = "indent" -- fold based on indent level

-- Enable persistent undo so that undo history persists across vim sessions
vim.opt.undofile = true

-- Highlight current line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Other
vim.opt.wildmenu = true -- visual autocomplete for command menu
vim.opt.lazyredraw = true -- slow redraw, faster macros
vim.opt.showmatch = true -- live match highlighting
vim.opt.updatetime = 100 -- faster plugins
-- vim.opt.noshowmode = true
vim.opt.showtabline = 2 -- always show tabline
vim.opt.hidden = true -- enable hidden buffers (change buffers without saving)
vim.opt.clipboard = "unnamedplus" -- use global clipboard
vim.opt.cmdheight = 1
vim.opt.mouse = "a"
