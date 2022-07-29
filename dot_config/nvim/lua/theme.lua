local M = {}

vim.o.termguicolors = true
vim.opt.background = "dark" -- Force dark background

function M.ayu()
    vim.cmd[[let ayucolor="dark"]]
    vim.cmd[[colorscheme ayu]]
end

function M.gruvbox()
    -- vim.g.gruvbox_material_background = 'medium'
    -- vim.g.gruvbox_material_palette = 'original'
    -- vim.g.gruvbox_material_enable_bold = 1
    -- vim.g.gruvbox_material_enable_italic = 1
    -- vim.g.gruvbox_material_sign_column_background = 'none'
    -- vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'

    vim.g.gruvbox_contrast_dark = "soft"
    vim.cmd[[colorscheme gruvbox-material]]
end

function M.tokyonight()
    vim.cmd[[colorscheme tokyonight]]
end

function M.monokaipro()
    vim.g.monokaipro_filter = "spectrum"
    vim.cmd[[colorscheme monokaipro]]
end

function M.kanagawa()
    vim.cmd[[colorscheme kanagawa]]
end

return M
