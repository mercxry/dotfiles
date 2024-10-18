return {
  { "tpope/vim-fugitive" }, -- It should be illegal
  { "tpope/vim-rhubarb" }, -- Github support
  { "junegunn/gv.vim" }, -- Commit Browser
  { "APZelos/blamer.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      attach_to_untracked = false,
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 400,
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
        map("n", "<leader>ghD", function()
          gs.diffthis "~"
        end, "Diff This ~")
        --[[ map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk") ]]
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<CR>", desc = "Diff staged" },
      { "<leader>gdm", "<cmd>DiffviewOpen origin/main...HEAD<CR>", desc = "Diff main..HEAD" },
    },
    config = function()
      vim.api.nvim_create_user_command("DiffviewToggle", function(e)
        local view = require("diffview.lib").get_current_view()

        if view then
          vim.cmd "DiffviewClose"
        else
          vim.cmd("DiffviewOpen " .. e.args)
        end
      end, { nargs = "*" })
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    keys = {
      { "<leader>gcc", "<Plug>(git-conflict-ours)", desc = "Choose current" },
      { "<leader>gci", "<Plug>(git-conflict-theirs)", desc = "Choose incoming" },
      { "<leader>gcb", "<Plug>(git-conflict-both)", desc = "Choose both" },
      { "<leader>gc0", "<Plug>(git-conflict-none)", desc = "Ignore" },
      { "<leader>gcp", "<Plug>(git-conflict-prev-conflict)", desc = "Go to previous" },
      { "<leader>gcn", "<Plug>(git-conflict-next-conflict)", desc = "Go to next" },
    },
    config = function()
      require("git-conflict").setup {
        default_mappings = false,
      }

      --[[ vim.keymap.set("n", "<leader>gcc", "<Plug>(git-conflict-ours)") ]]
      --[[ vim.keymap.set("n", "<leader>gci", "<Plug>(git-conflict-theirs)") ]]
      --[[ vim.keymap.set("n", "<leader>gcb", "<Plug>(git-conflict-both)") ]]
      --[[ vim.keymap.set("n", "<leader>gc0", "<Plug>(git-conflict-none)") ]]
      --[[ vim.keymap.set("n", "<leader>gcp", "<Plug>(git-conflict-prev-conflict)") ]]
      --[[ vim.keymap.set("n", "<leader>gcn", "<Plug>(git-conflict-next-conflict)") ]]
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      {
        "<leader>gy",
        mode = "n",
        function()
          require("gitlinker").get_buf_range_url("n", {})
        end,
        desc = "Copy git link",
      },
      {
        "<leader>gy",
        mode = "v",
        function()
          require("gitlinker").get_buf_range_url("v", {})
        end,
        desc = "Copy git link (Visual mode)",
      },
      {
        "<leader>gb",
        mode = "n",
        function()
          require("gitlinker").get_buf_range_url(
            "n",
            { action_callback = require("gitlinker.actions").open_in_browser }
          )
        end,
        desc = "Open git link in browser",
      },
      {
        "<leader>gb",
        mode = "v",
        function()
          require("gitlinker").get_buf_range_url(
            "v",
            { action_callback = require("gitlinker.actions").open_in_browser }
          )
        end,
        desc = "Open git link in browser (Visual mode)",
      },
    },
    config = function()
      require("gitlinker").setup()
    end,
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    -- stylua: ignore
    keys = {
      { "<leader>gpl", "<cmd>Octo pr list<CR>",       desc = "List PRs" },
      { "<leader>gpi", "<cmd>Octo review start<CR>",  desc = "Init PR review" },
      { "<leader>gpr", "<cmd>Octo review resume<CR>", desc = "Resume review" },
      { "<leader>gpc", "<cmd>Octo review close<CR>",  desc = "Close review" },
      { "<leader>gps", "<cmd>Octo review submit<CR>", desc = "Submit review" },
    },
    config = true,
  },
}
