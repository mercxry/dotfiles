return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/syncthing/obsidian-vaults/Minerva/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/syncthing/obsidian-vaults/Minerva/*.md",
  },
  -- stylua: ignore
  keys = {
    { "<leader>oo", "<cmd>ObsidianOpen<cr>",              desc = "Open in Obsidian" },
    { "<leader>on", "<cmd>ObsidianNew<cr>",               desc = "New note" },
    { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>",       desc = "Files" },
    { "<leader>o/", "<cmd>ObsidianSearch<cr>",            desc = "Search" },
    { "<leader>ox", "<cmd>ObsidianFollowLink<cr>",        desc = "Follow link" },
    { "<leader>o-", "<cmd>ObsidianFollowLink hsplit<cr>", desc = "Follow link (hsplit)" },
    { "<leader>o|", "<cmd>ObsidianFollowLink vsplit<cr>", desc = "Follow link (vsplit)" },
    { "<leader>or", "<cmd>ObsidianBacklinks<cr>",         desc = "Backlinks" },
    { "<leader>od", "<cmd>ObsidianDailies -7 1<cr>",      desc = "Dailies" },
    { "<leader>ot", "<cmd>ObsidianToday<cr>",             desc = "Today's note" },
    { "<leader>oc", "<cmd>ObsidianTOC<cr>",               desc = "Table of contents" },
    { "<leader>o#", "<cmd>ObsidianTags<cr>",              desc = "Search by tag" },
    { "<leader>oi", "<cmd>ObsidianPasteImg<cr>",          desc = "Paste image" },
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/syncthing/obsidian-vaults/Minerva",
        overrides = {
          notes_subdir = "00. Inbox",
          daily_notes = {
            folder = "04. Daily",
            date_format = "%Y-%m-%d",
          },
          templates = {
            folder = "99. Meta/Templates",
          },
        },
      },
    },
  },
}
