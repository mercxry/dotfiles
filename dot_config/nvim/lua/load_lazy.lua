-- Bootstrap lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Automatically PackerSync when this file is changed
--[[ local cfgGrp = api.nvim_create_augroup("PackerUserConfig", { clear = true }) ]]
--[[ api.nvim_create_autocmd("BufWritePost", { ]]
--[[     pattern = "plugins.lua", ]]
--[[     command = "source <afile> | PackerSync", ]]
--[[     group = cfgGrp, ]]
--[[ }) ]]

require("lazy").setup("plugin-spec", {
    install = {
        colorscheme = { "kanagawa" }
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        }
    }
})
