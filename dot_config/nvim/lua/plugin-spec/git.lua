return {
    { "tpope/vim-fugitive" }, -- It should be illegal
    { "tpope/vim-rhubarb" },  -- Github support
    { "junegunn/gv.vim" },    -- Commit Browser
    { "APZelos/blamer.nvim" },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            attach_to_untracked = false,
            current_line_blame = true,
            current_line_blame_formatter_opts = {
                relative_time = true
            },
            current_line_blame_opts = {
                delay = 400
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                --[[ map("n", "]h", gs.next_hunk, "Next Hunk") ]]
                --[[ map("n", "[h", gs.prev_hunk, "Prev Hunk") ]]
                --[[ map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk") ]]
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                --[[ map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer") ]]
                --[[ map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk") ]]
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>ghpi", gs.preview_hunk_inline, "Preview Hunk")
                --[[ map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line") ]]
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                --[[ map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk") ]]
            end,
        },
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
        end,
        keys = {
            {
                "<leader>gdm",
                function()
                    vim.cmd [[DiffviewOpen origin/main...HEAD]]
                end
            },
            {
                "<leader>gd",
                function()
                    vim.cmd [[DiffviewToggle]]
                end
            },
        }
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
        keys = {
            {
                "<leader>gprl",
                function()
                    vim.cmd [[Octo pr list]]
                end
            },
            {
                "<leader>grs",
                function()
                    vim.cmd [[Octo review start]]
                end
            },
            {
                "<leader>grr",
                function()
                    vim.cmd [[Octo review resume]]
                end
            },
            {
                "<leader>grc",
                function()
                    vim.cmd [[Octo review close]]
                end
            },
            {
                "<leader>grsu",
                function()
                    vim.cmd [[Octo review submit]]
                end
            },
        },
        config = true
    }
}
