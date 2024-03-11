return {
    { "christoomey/vim-tmux-navigator" }, -- Tmux navigator integration
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
        build = ":TSUpdate",
        --[[ event = { "BufReadPost", "BufNewFile" }, ]]
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
            }
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            -- Skip backwards compatibility routines and speed up loading.
            vim.g.skip_ts_context_commentstring_module = true

            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }
        end
    },
    {
        "windwp/nvim-autopairs",
        config = true,
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
        config = true
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

            --[[ local navic = require("nvim-navic") ]]
            require('lualine').setup({
                options = {
                    theme = vim.g.colors_name,
                    globalstatus = true,
                },
                sections = {
                    lualine_c = {
                        { 'filename', file_status = false,    path = 1,        icons_enabled = true },
                        { 'navic',    color_correction = nil, navic_opts = nil },
                    },
                    lualine_z = { improved_location },
                }
            })
        end,
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons", "famiu/bufdelete.nvim" },
        event = {
            "BufAdd",
            "BufRead",
        },
        opts = {
            options = {
                numbers = function(opts)
                    return string.format('%s.', opts.ordinal)
                end,
                diagnostics = 'nvim-lsp',
                show_close_icon = false,
            }
        },
        keys = {
            {
                "<TAB>",
                function()
                    vim.cmd [[BufferLineCycleNext]]
                end
            },
            {
                "<A-TAB>",
                function()
                    vim.cmd [[BufferLineCyclePrev]]
                end
            },
            {
                "<A-w>",
                function()
                    vim.cmd [[bdelete]]
                end
            },
            {
                "<A-W>",
                function()
                    vim.cmd [[bdelete!]]
                end
            },
            {
                "<A-0>",
                function()
                    vim.cmd [[BufferLinePick]]
                end
            },
            {
                "<A-1>",
                function()
                    vim.cmd [[BufferLineGoToBuffer 1]]
                end
            },
            {
                "<A-2>",
                function()
                    vim.cmd [[BufferLineGoToBuffer 2]]
                end
            },
            {
                "<A-3>",
                function()
                    vim.cmd [[BufferLineGoToBuffer 3]]
                end
            },
            {
                "<A-4>",
                function()
                    vim.cmd [[BufferLineGoToBuffer 4]]
                end
            },
            {
                "<A-5>",
                function()
                    vim.cmd [[BufferLineGoToBuffer 5]]
                end
            },
            {
                "<A-6>",
                function()
                    vim.cmd [[BufferLineGoToBuffer 6]]
                end
            },
            {
                "<A-7>",
                function()
                    vim.cmd [[BufferLineGoToBuffer 7]]
                end
            },
            {
                "<A-8>",
                function()
                    vim.cmd [[BufferLineGoToBuffer 8]]
                end
            },
            {
                "<A-9>",
                function()
                    vim.cmd [[BufferLineGoToBuffer 9]]
                end
            },
        },
    },
    {
        "mbbill/undotree",
        keys = {
            {
                "<leader>u",
                function()
                    vim.cmd [[UndotreeToggle]]
                end
            }
        },
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "monaqa/dial.nvim",
        lazy = true,
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
    {
        "anuvyklack/fold-preview.nvim",
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
        keys = {
            {
                "<leader>S",
                function()
                    require("spectre").open()
                end
            },
        },
        config = true
    },
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {
            { "kkharji/sqlite.lua" },
            { "nvim-telescope/telescope.nvim" },
        },
        opts = {
            enable_persistent_history = true,
        },
        keys = {
            {
                "<leader>pb",
                function()
                    require('telescope').extensions.neoclip.default()
                end
            },
            {
                "<leader>mb",
                function()
                    require('telescope').extensions.macroscope.default()
                end
            },
        }
    },
    {
        "jinh0/eyeliner.nvim",
        config = function()
            require "eyeliner".setup {
                highlight_on_key = true
            }
        end
    },
    {
        "johmsalas/text-case.nvim",
        opts = {},
        config = function()
            require('telescope').load_extension('textcase')
            vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescopeQuickChange<CR>', { desc = "Telescope" })
            vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescopeQuickChange<CR>", { desc = "Telescope" })
        end,
        keys = {
            { "ga.", "<cmd>TextCaseOpenTelescopeQuickChange<CR>", { "n", "v" }, desc = "Change casing of word" },
        },
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            require("statuscol").setup()
        end
    },
    {
        "petertriho/nvim-scrollbar",
        cond = false,
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "kevinhwang91/nvim-hlslens",
        },
        config = function()
            require("scrollbar").setup()
            require("scrollbar.handlers.gitsigns").setup()
            require("scrollbar.handlers.search").setup()
        end
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = {
            "neovim/nvim-lspconfig"
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
        },
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'wakatime/vim-wakatime',
        lazy = false
    }
}
