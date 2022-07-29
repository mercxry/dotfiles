vim.g.neo_tree_remove_legacy_commands = 1

require("neo-tree").setup({
    -- close_if_last_window = true,
    window = {
        position = "left",
    },
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
            never_show = {
                ".DS_Store",
                "thumbs.db"
            },
        },
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
    }
})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>Neotree focus filesystem toggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tf', '<cmd>Neotree focus filesystem float toggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tb', '<cmd>Neotree focus buffers float toggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tg', '<cmd>Neotree focus git_status float toggle<CR>', opts)
