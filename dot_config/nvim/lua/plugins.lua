local fn = vim.fn
local api = vim.api

-- Bootstrap packer if not installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

-- Automatically PackerSync when this file is changed
local cfgGrp = api.nvim_create_augroup("PackerUserConfig", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    command = "source <afile> | PackerSync",
    group = cfgGrp,
})

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use("lewis6991/impatient.nvim")
    use("dstein64/vim-startuptime")

    ------------
    -- Themes --
    ------------
    use("rebelot/kanagawa.nvim")

    if false then
        use("ayu-theme/ayu-vim")
        use("navarasu/onedark.nvim")
        use("folke/tokyonight.nvim")
        use("sainnhe/gruvbox-material")
        use("https://gitlab.com/__tpb/monokai-pro.nvim")
    end

    ---------------------
    -- File Management --
    ---------------------
    -- use({
    --     "kyazdani42/nvim-tree.lua",
    --     requires = "kyazdani42/nvim-web-devicons",
    --     config = function()
    --         require("plugins.tree")
    --     end,
    -- })
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("plugins.neotree")
        end
    })

    ---------
    -- Git --
    ---------
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.gitsigns")
        end,
    })
    use("tpope/vim-fugitive") -- It should be illegal
    use("tpope/vim-rhubarb") -- Github support
    use("junegunn/gv.vim") -- Commit Browser
    use("APZelos/blamer.nvim")
    use({
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim"
    })
    use({
        "akinsho/git-conflict.nvim",
        tag = "*",
        config = function()
            require("plugins.git-conflict")
        end
    })
    use {
        "ruifm/gitlinker.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.gitlinker")
        end
    }

    ---------------
    -- Telescope --
    ---------------
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.telescope")
        end,
    })
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    })

    ---------
    -- LSP --
    ---------
    use({
        "neovim/nvim-lspconfig",
        -- requires = { "nvim-lua/lsp-status.nvim" },
        config = function()
            require("plugins.lsp")
        end,
    })
    use {
        "williamboman/nvim-lsp-installer",
        requires = "neovim/nvim-lspconfig",
        config = function()
            require("nvim-lsp-installer").setup { automatic_installation = false }
        end
    }
    use("liuchengxu/vista.vim") -- LSP symbol and tags viewer
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({})
        end,
    })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.null-ls")
        end,
    })
    use({
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({})
        end,
    })

    -----------------------
    -- Completion Engine --
    -----------------------
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "onsails/lspkind-nvim",
            "ray-x/cmp-treesitter",
            "andersevenrud/cmp-tmux",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "davidsierradz/cmp-conventionalcommits",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("plugins.cmp")
        end,
    })
    use("rafamadriz/friendly-snippets")
    use({
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    })

    ----------------
    -- Navigation --
    ----------------
    use("christoomey/vim-tmux-navigator") -- Tmux navigator integration
    use({
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    })
    use({
        "nacro90/numb.nvim",
        config = function()
            require("numb").setup()
        end
    })
    use({
        "chentoast/marks.nvim",
        config = function()
            require("marks").setup({})
        end
    })

    -----------------
    -- Programming --
    -----------------
    use({
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.treesitter")
        end,
        run = ":TSUpdate",
    })
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.comment")
        end,
    })
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- use({
    -- 	"folke/todo-comments.nvim",
    -- 	requires = "nvim-lua/plenary.nvim",
    -- 	config = function()
    -- 		require("todo-comments").setup({})
    -- 	end,
    -- })

    -- use("tpope/vim-surround")

    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
            })
        end
    })

    ----------
    -- Rust --
    ----------
    use({
        "simrat39/rust-tools.nvim",
        config = function()
            require("plugins.rust-tools")
        end,
    })
    use({
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup()
        end,
    })

    -------------------
    -- Editor Config --
    -------------------
    use("editorconfig/editorconfig-vim")

    ----------------
    -- Statusline --
    ----------------
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("plugins.lualine")
        end,
    })
    use({
        "akinsho/bufferline.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("plugins.bufferline")
        end,
    })
    use({
        "famiu/bufdelete.nvim",
        after = "bufferline.nvim",
    })

    ---------------
    -- Debugging --
    ---------------
    use({
        "mfussenegger/nvim-dap",
        config = function()
            require("plugins.dap")
        end
    })
    use { 'nvim-telescope/telescope-dap.nvim' }
    use {
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()
        end
    }

    -----------
    -- Other --
    -----------
    use({
        "nvim-lua/popup.nvim",
        requires = "nvim-lua/plenary.nvim"
    })


    -- Visualize undo tree
    use({
        "mbbill/undotree",
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { silent = true })
        end
    })
    use("airblade/vim-rooter") -- Set the working directory to the project root
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use({
        -- Discord Presence
        "andweeb/presence.nvim",
        disable = true,
        config = function()
            require("plugins.presence")
        end,
    })
    use("wakatime/vim-wakatime")
    use({
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup()
        end,
    })
    use({
        "rcarriga/nvim-notify",
        disable = true,
        config = function()
            require("plugins.notify")
        end,
    })
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })
    use({
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.dashboard").config)
        end,
    })
    -- use({
    --     "lukas-reineke/indent-blankline.nvim",
    --     config = function()
    --         require("plugins.indent-blankline")
    --     end,
    -- })
    use("antoinemadec/FixCursorHold.nvim")
    use("romainl/vim-cool")
    use({
        "stevearc/dressing.nvim",
        config = function()
            require("dressing").setup()
        end
    })
    use({
        "monaqa/dial.nvim",
        config = function()
            require("plugins.dial")
        end
    })
    use({
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    })
    use({ "junegunn/fzf", run = function()
        vim.fn["fzf#install"]()
    end
    })
    use { "anuvyklack/fold-preview.nvim",
        requires = "anuvyklack/keymap-amend.nvim",
        config = function()
            require("fold-preview").setup()
        end
    }
    use({
        "windwp/nvim-spectre",
        requires = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("plugins.spectre")
        end
    })
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {
            { "kkharji/sqlite.lua", module = "sqlite" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("plugins.neoclip")
        end,
    }
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("plugins.lsp_lines")
        end,
    })
    use {
        "jinh0/eyeliner.nvim",
        config = function()
            require "eyeliner".setup {
                highlight_on_key = true
            }
        end
    }
    use { "johmsalas/text-case.nvim",
        config = function()
            require('textcase').setup {}
            require('telescope').load_extension('textcase')
            vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescopeQuickChange<CR>', { desc = "Telescope" })
            vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescopeQuickChange<CR>", { desc = "Telescope" })
        end
    }
    use("github/copilot.vim")
    use {
        "potamides/pantran.nvim",
        config = function()
            require("pantran").setup {}
        end
    }
    use({
        "voldikss/vim-floaterm",
        config = function()
            vim.api.nvim_set_keymap("n", "<F7>", ":FloatermNew<CR>", { silent = true })
            vim.api.nvim_set_keymap("n", "<F8>", ":FloatermPrev<CR>", { silent = true })
            vim.api.nvim_set_keymap("n", "<F9>", ":FloatermNext<CR>", { silent = true })
            vim.api.nvim_set_keymap("n", "<F12>", ":FloatermToggle<CR>", { silent = true })
        end
    })
    use("aklt/plantuml-syntax")
    use({
        "weirongxu/plantuml-previewer.vim",
        requires = "tyru/open-browser.vim"
    })
    use({
        "nathom/filetype.nvim",
        config = function()
            require("plugins.filetype")
        end
    })

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require("packer").sync()
    end
end)
