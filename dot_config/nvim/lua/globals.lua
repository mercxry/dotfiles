-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2

-- Set relative numbers in normal mode but not in insert mode
vim.cmd([[autocmd InsertEnter * :set norelativenumber]])
vim.cmd([[autocmd InsertLeave * :set relativenumber]])

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

-- Don't continue comments when pressing "o" to create a new line
local autoGroup = vim.api.nvim_create_augroup("autoGroup", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    group = autoGroup,
    pattern = "*",
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions
            - "c"
            - "r"
            - "o"
    end,
})

-- vim.cmd([[
--     augroup CLOSE_IF_LAST_BUFFER
--         autocmd!
--         autocmd BufDelete * silent! if len(getbufinfo({'buflisted':1})) == 0 | q | endif
--     augroup END
-- ]])

-- Bind uppercase quit and write
vim.cmd([[:command W w]])
vim.cmd([[:command Q q]])
vim.cmd([[:command WQ wq]])
vim.cmd([[:command Wq wq]])
