-- Bootstrap packer if not installed
local fn = vim.fn
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

-- Automatically PackerCompile when this file is changed
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")

	-- Themes
	use("ayu-theme/ayu-vim")
	use("navarasu/onedark.nvim")
	use("folke/tokyonight.nvim")

	-- File Management
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.tree")
		end,
	})

	-- Git
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
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

	-- Search
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

	-- LSP & Snippet Engine
	use({
		"neovim/nvim-lspconfig",
        requires = { "nvim-lua/lsp-status.nvim" },
		config = function()
			require("plugins.lsp")
		end,
	})
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

	-- Completion Engine
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"ray-x/cmp-treesitter",
			"onsails/lspkind-nvim",
		},
		config = function()
			require("plugins.cmp")
		end,
	})

	-- Programming
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
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})
	use("tpope/vim-surround")

	-- Rust
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

	-- Editor Config
	use("editorconfig/editorconfig-vim")

	-- Statusline
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

	-- Other
	use({ "nvim-lua/popup.nvim", requires = "nvim-lua/plenary.nvim" })
	use("mfussenegger/nvim-dap") -- Debugging
	use("mbbill/undotree") -- Visualize undo tree
	use("airblade/vim-rooter") -- Set the working directory to the project root
	use({ "iamcco/markdown-preview.nvim", run = "cd app & yarn install" }) -- Markdown support
	use("christoomey/vim-tmux-navigator") -- Tmux navigator integration
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
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	})
	use({
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	})
    use({
        "rcarriga/nvim-notify",
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

	-- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		require("packer").sync()
	end
end)
