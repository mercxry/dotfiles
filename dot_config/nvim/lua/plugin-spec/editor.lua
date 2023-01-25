return {
    { "christoomey/vim-tmux-navigator" }, -- Tmux navigator integration
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
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
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local M = {}

            M.project_files = function()
                local opts = {}
                local ok = pcall(require "telescope.builtin".git_files, opts)
                if not ok then require "telescope.builtin".find_files(opts) end
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

            vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>",
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>/", "<cmd>lua require('telescope.builtin').live_grep()<CR>",
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>",
                { noremap = true, silent = true })

            return M
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    },
    {
        "nacro90/numb.nvim",
        config = function()
            require("numb").setup()
        end
    },
    {
        "chentoast/marks.nvim",
        config = function()
            require("marks").setup({})
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = "all",
                highlight = {
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
                ignore_install = { "phpdoc", "tree-sitter-phpdoc" },
                -- indent = {
                --   enable = true
                -- }
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                }
            }
        end,
        build = ":TSUpdate",
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup {
                pre_hook = function(ctx)
                    local U = require 'Comment.utils'

                    local location = nil
                    if ctx.ctype == U.ctype.block then
                        location = require('ts_context_commentstring.utils').get_cursor_location()
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = require('ts_context_commentstring.utils').get_visual_start_location()
                    end

                    return require('ts_context_commentstring.internal').calculate_commentstring {
                        key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
                        location = location,
                    }
                end,
            }
        end,
    },

    -- {
    -- 	"folke/todo-comments.nvim",
    -- 	dependencies = "nvim-lua/plenary.nvim",
    -- 	config = function()
    -- 		require("todo-comments").setup({},
    -- 	end,
    -- },

    -- "tpope/vim-surround")

    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
        config = function()
            -- Location with current line and column, and total lines in file
            local function improved_location()
                local r, c = unpack(vim.api.nvim_win_get_cursor(0))
                return string.format("%d:%d | %d", r, c, vim.fn.line('$'))
            end

            require('lualine').setup({
                options = {
                    theme = vim.g.colors_name,
                    globalstatus = true,
                },
                sections = {
                    lualine_c = {
                        { 'filename', file_status = false, path = 1, icons_enabled = true },
                    },
                    lualine_z = { improved_location },
                }
            })

        end,
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
        config = function()
            require("bufferline").setup {
                options = {
                    numbers = function(opts)
                        return string.format('%s.', opts.ordinal)
                    end,
                    diagnostics = 'nvim-lsp',
                    show_close_icon = false,
                }
            }

            local opts = { noremap = true, silent = true }

            vim.api.nvim_set_keymap('n', '<TAB>', '<cmd>BufferLineCycleNext<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-TAB>', '<cmd>BufferLineCyclePrev<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-w>', '<cmd>bdelete<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-W>', '<cmd>bdelete!<CR>', opts)

            vim.api.nvim_set_keymap('n', '<A-0>', '<cmd>BufferLinePick<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-1>', '<cmd>BufferLineGoToBuffer 1<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-2>', '<cmd>BufferLineGoToBuffer 2<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-3>', '<cmd>BufferLineGoToBuffer 3<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-4>', '<cmd>BufferLineGoToBuffer 4<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-5>', '<cmd>BufferLineGoToBuffer 5<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-6>', '<cmd>BufferLineGoToBuffer 6<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-7>', '<cmd>BufferLineGoToBuffer 7<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-8>', '<cmd>BufferLineGoToBuffer 8<CR>', opts)
            vim.api.nvim_set_keymap('n', '<A-9>', '<cmd>BufferLineGoToBuffer 9<CR>', opts)
        end,
    },
    {
        "famiu/bufdelete.nvim",
        dependencies = "bufferline.nvim",
    },
    {
        "mbbill/undotree",
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { silent = true })
        end
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "monaqa/dial.nvim",
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group {
                default = {
                    augend.integer.alias.decimal_int,
                    augend.constant.alias.bool,
                    augend.integer.alias.hex,
                    augend.integer.alias.octal,
                    augend.integer.alias.binary,
                    augend.semver.alias.semver,
                    augend.date.alias["%d/%m/%y"],
                    augend.date.alias["%d/%m/%Y"],
                },
            }

            vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
            vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
            vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
            vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
            vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
            vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
        end
    },
    { "anuvyklack/fold-preview.nvim",
        dependencies = "anuvyklack/keymap-amend.nvim",
        config = function()
            require("fold-preview").setup()
        end
    },
    {
        "windwp/nvim-spectre",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require('spectre').setup()

            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap('n', '<leader>S', '<cmd>lua require(\'spectre\').open()<CR>', opts)
        end
    },
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {
            { "kkharji/sqlite.lua" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require('neoclip').setup(
                {
                    enable_persistent_history = true,
                }
            )

            vim.api.nvim_set_keymap("n", "<leader>pb", "<cmd>lua require('telescope').extensions.neoclip.default()<CR>",
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>mb",
                "<cmd>lua require('telescope').extensions.macroscope.default()<CR>",
                { noremap = true, silent = true })
        end,
    },
    {
        "jinh0/eyeliner.nvim",
        config = function()
            require "eyeliner".setup {
                highlight_on_key = true
            }
        end
    },
    { "johmsalas/text-case.nvim",
        config = function()
            require('textcase').setup({})
            require('telescope').load_extension('textcase')
            vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescopeQuickChange<CR>', { desc = "Telescope" })
            vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescopeQuickChange<CR>", { desc = "Telescope" })
        end
    },
}
