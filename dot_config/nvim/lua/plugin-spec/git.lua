return {
    { "tpope/vim-fugitive" }, -- It should be illegal
    { "tpope/vim-rhubarb" }, -- Github support
    { "junegunn/gv.vim" }, -- Commit Browser
    { "APZelos/blamer.nvim" },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local gitsigns = require('gitsigns')

            gitsigns.setup {
                current_line_blame = true,
                current_line_blame_formatter_opts = {
                    relative_time = true
                },
                current_line_blame_opts = {
                    delay = 400
                },
            }
        end,
    },
    {
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            vim.api.nvim_create_user_command("DiffviewToggle", function(e)
                local view = require("diffview.lib").get_current_view()

                if view then
                    vim.cmd("DiffviewClose")
                else
                    vim.cmd("DiffviewOpen " .. e.args)
                end
            end, { nargs = "*" })

            vim.api.nvim_set_keymap("n", "<leader>gdm", ":DiffviewOpen origin/main...HEAD<CR>", { silent = true })
            vim.api.nvim_set_keymap("n", "<leader>gd", ":DiffviewToggle<CR>", { silent = true })
        end
    },
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = function()
            require("git-conflict").setup({
                default_mappings = false,
            })

            vim.keymap.set('n', '<leader>gcc', '<Plug>(git-conflict-ours)')
            vim.keymap.set('n', '<leader>gci', '<Plug>(git-conflict-theirs)')
            vim.keymap.set('n', '<leader>gcb', '<Plug>(git-conflict-both)')
            vim.keymap.set('n', '<leader>gc0', '<Plug>(git-conflict-none)')
            vim.keymap.set('n', '<leader>gcp', '<Plug>(git-conflict-prev-conflict)')
            vim.keymap.set('n', '<leader>gcn', '<Plug>(git-conflict-next-conflict)')
        end
    },
    {
        "ruifm/gitlinker.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("gitlinker").setup()

            vim.api.nvim_set_keymap('n', '<leader>gb',
                '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
                , { silent = true })
            vim.api.nvim_set_keymap('v', '<leader>gb',
                '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
                , {})
        end
    },
    {
        "pwntester/octo.nvim",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'kyazdani42/nvim-web-devicons',
        },
        config = function()
            require "octo".setup()

            vim.api.nvim_set_keymap("n", "<leader>gprl", ":Octo pr list<CR>", { silent = true })
            vim.api.nvim_set_keymap("n", "<leader>grs", ":Octo review start<CR>", { silent = true })
            vim.api.nvim_set_keymap("n", "<leader>grr", ":Octo review resume<CR>", { silent = true })
            vim.api.nvim_set_keymap("n", "<leader>grc", ":Octo review close<CR>", { silent = true })
            vim.api.nvim_set_keymap("n", "<leader>grsu", ":Octo review submit<CR>", { silent = true })
        end
    }
}
