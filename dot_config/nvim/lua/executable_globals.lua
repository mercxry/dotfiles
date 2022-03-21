-- No VI settings, thanks
vim.cmd([[set nocompatible]])

-- We have git, so this is useless
vim.cmd([[set nobackup]])
vim.cmd([[set nowritebackup]])
vim.cmd([[set noswapfile]])

-- Line Numbers
vim.cmd([[set number relativenumber]])
vim.cmd([[set numberwidth=2]])

-- Set relative numbers in normal mode but not in insert mode
vim.cmd([[autocmd InsertEnter * :set norelativenumber]])
vim.cmd([[autocmd InsertLeave * :set relativenumber]])

-- Indents
vim.cmd([[set expandtab]]) -- use spaces instead of tabs
vim.cmd([[set tabstop=4 shiftwidth=4]]) -- tab creates 4 spaces
vim.cmd([[set smarttab]]) -- Delete spaces based on tabstop
vim.cmd([[set autoindent]])

-- Better Search
vim.cmd([[set ignorecase]]) -- case insensitive search
vim.cmd([[set smartcase]]) -- if there are uppercase letters, it becomes case-sensitive
vim.cmd([[set incsearch]]) -- live incremental searching
vim.cmd([[set hlsearch]]) -- highlight matches
vim.cmd([[set gdefault]]) -- use the `g` flag by default.

-- Folding
vim.cmd([[set foldenable]]) -- enable folding
vim.cmd([[set foldlevelstart=10]]) -- open most folds by default
vim.cmd([[set foldnestmax=10]]) -- 10 nested fold max
vim.cmd([[set foldmethod=indent]]) -- fold based on indent level

-- Enable persistent undo so that undo history persists across vim sessions
vim.cmd([[set undofile]])
vim.cmd([[set undodir=~/.vim/undo]])

-- Other
vim.cmd([[set wildmenu]]) -- visual autocomplete for command menu
vim.cmd([[set lazyredraw]]) -- slow redraw, faster macros
vim.cmd([[set showmatch]]) -- live match highlighting
vim.cmd([[set updatetime=100]]) -- faster plugins
vim.cmd([[set noshowmode ]])
vim.cmd([[set showtabline=2]]) -- always show tabline
vim.cmd([[set hidden]]) -- enable hidden buffers (change buffers without saving)
vim.cmd([[set clipboard+=unnamedplus]]) -- use global clipboard
vim.opt.cmdheight = 2

-- Bind uppercase quit and write
vim.cmd([[:command W w]])
vim.cmd([[:command Q q]])
vim.cmd([[:command WQ wq]])
vim.cmd([[:command Wq wq]])
