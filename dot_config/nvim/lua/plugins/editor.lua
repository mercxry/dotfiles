return {
  { "christoomey/vim-tmux-navigator" }, -- Tmux navigator integration
  { "mfussenegger/nvim-overfly" },
  {
    "echasnovski/mini.nvim",
    version = "*",
    keys = {
      {
        "<C-n>",
        "<cmd>lua MiniFiles.open()<CR>",
        desc = "Open file explorer",
      },
      {
        "<leader>e",
        "<cmd>lua MiniFiles.open()<CR>",
        desc = "Open file explorer",
      },
    },
    config = function()
      require("mini.ai").setup()
      require("mini.basics").setup()

      require("mini.files").setup {
        mappings = {
          go_in_plus = "<CR>",
        },
        windows = {
          preview = true,
          width_nofocus = 25,
          width_preview = 100,
        },
      }

      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>lua MiniFiles.open()<CR>", opts)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>/", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Live Grep" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      {
        "<leader>ff",
        "<cmd>lua require('telescope.builtin').find_files()<CR>",
        desc = "Find Files",
      },
      {
        "<leader>fg",
        "<cmd>Telescope git_files<cr>",
        desc = "Find Files (git-files)",
      },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      -- git
      { "<leader>gl", "<cmd>Telescope git_commits<CR>", desc = "Log commits" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      {
        "<leader>sd",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        desc = "Document Diagnostics",
      },
      {
        "<leader>sD",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Workspace Diagnostics",
      },
      { "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Grep (Root Dir)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      {
        "<leader>sH",
        "<cmd>Telescope highlights<cr>",
        desc = "Search Highlight Groups",
      },
      { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
    },
    config = function()
      local M = {}

      M.project_files = function()
        local opts = {}
        local ok = pcall(require("telescope.builtin").git_files, opts)
        if not ok then
          require("telescope.builtin").find_files(opts)
        end
      end

      require("telescope").setup {
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
      }

      require("telescope").load_extension "fzf"

      return M
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  {
    "karb94/neoscroll.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local opts = {
        mappings = {
          "<C-u>",
          "<C-d>",
        },
      }
      require("neoscroll").setup(opts)
    end,
  },
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  },
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup {}
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    --[[ event = { "BufReadPost", "BufNewFile" }, ]]
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = "all",
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        ignore_install = { "org", "phpdoc", "tree-sitter-phpdoc" },
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

      require("ts_context_commentstring").setup {
        enable_autocmd = false,
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        pre_hook = function(ctx)
          local U = require "Comment.utils"

          local location = nil
          if ctx.ctype == U.ctype.block then
            location = require("ts_context_commentstring.utils").get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
          end

          return require("ts_context_commentstring.internal").calculate_commentstring {
            key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
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
    config = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
    config = function()
      -- Location with current line and column, and total lines in file
      local function improved_location()
        local r, c = unpack(vim.api.nvim_win_get_cursor(0))
        return string.format("%d:%d | %d", r, c, vim.fn.line "$")
      end

      --[[ local navic = require("nvim-navic") ]]
      require("lualine").setup {
        options = {
          theme = vim.g.colors_name,
          globalstatus = true,
        },
        sections = {
          lualine_c = {
            { "filename", file_status = false, path = 1, icons_enabled = true },
            { "navic", color_correction = nil, navic_opts = nil },
          },
          lualine_z = { improved_location },
        },
      }
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
          return string.format("%s.", opts.ordinal)
        end,
        diagnostics = "nvim-lsp",
        show_close_icon = false,
      },
    },
    keys = {
      { "<TAB>", "<cmd>BufferLineCycleNext<CR>", desc = "Switch to next buffer" },
      { "<A-TAB>", "<cmd>BufferLineCyclePrev<CR>", desc = "Switch to previous buffer" },
      { "<A-w>", "<cmd>bdelete<CR>", desc = "Delete current buffer" },
      { "<A-W>", "<cmd>bdelete!<CR>", desc = "Force delete current buffer" },
      { "<A-0>", "<cmd>BufferLinePick<CR>", desc = "Pick a buffer" },
      { "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
      { "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
      { "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
      { "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
      { "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
      { "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
      { "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
      { "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
      { "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },
    },
  },
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>u",
        "<cmd>UndotreeToggle<CR>",
        desc = "Undo tree",
      },
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
      local augend = require "dial.augend"
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
    end,
  },
  {
    "anuvyklack/fold-preview.nvim",
    dependencies = "anuvyklack/keymap-amend.nvim",
    config = function()
      require("fold-preview").setup()
    end,
  },
  {
    "windwp/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Spectre (search and replace)",
      },
    },
    config = true,
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
        "<leader>sp",
        function()
          require("telescope").extensions.neoclip.default()
        end,
        desc = "Pasteboard history",
      },
      {
        "<leader>sM",
        function()
          require("telescope").extensions.macroscope.default()
        end,
        desc = "Macros",
      },
    },
  },
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup {
        highlight_on_key = true,
      }
    end,
  },
  {
    "johmsalas/text-case.nvim",
    opts = {},
    config = function()
      require("telescope").load_extension "textcase"
      vim.api.nvim_set_keymap("n", "ga.", "<cmd>TextCaseOpenTelescopeQuickChange<CR>", { desc = "Telescope" })
      vim.api.nvim_set_keymap("v", "ga.", "<cmd>TextCaseOpenTelescopeQuickChange<CR>", { desc = "Telescope" })
    end,
    keys = {
      { "ga.", "<cmd>TextCaseOpenTelescopeQuickChange<CR>", { "n", "v" }, desc = "Change casing of word" },
    },
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("statuscol").setup()
    end,
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
    end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
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
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
      { "<leader>E", "<cmd>Oil --float<cr>", desc = "Opens Oil in a float" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = false,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      watch_for_changes = true,
      keymaps = {
        ["<C-p>"] = false,
      },
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
}
