return {
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    -- stylua: ignore
    keys = {
      { "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" }
    },
    --[[ build = "cd app && npm install", ]]
    build = function(plugin)
      if vim.fn.executable "npx" then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd [[Lazy load markdown-preview.nvim]]
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      vim.cmd [[
        function OpenMarkdownPreview(url)
            exec "silent !open -a Min -n --args --new-window " . a:url
        endfunction
      ]]

      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    end,
    config = function()
      vim.g.mkdp_auto_close = false
      vim.g.mkdp_combine_preview = true
      vim.g.mkdp_echo_preview_url = true
      vim.g.mkdp_page_title = "${name}"
      vim.g.mkdp_port = 8007
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
  },
  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown",
    init = function()
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = "*.md",
        command = "MDResetListNumbering",
      })
    end,
    opts = {
      on_attach = function(bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr }
        map({ "n", "i" }, "<M-l><M-o>", "<Cmd>MDListItemBelow<CR>", opts)
        map({ "n", "i" }, "<M-L><M-O>", "<Cmd>MDListItemAbove<CR>", opts)
        map("n", "<M-c>", "<Cmd>MDTaskToggle<CR>", opts)
        map("x", "<M-c>", ":MDTaskToggle<CR>", opts)
      end,
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      --[[ { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" }, ]]
    },
  },
  {
    "3rd/image.nvim",
    config = function() end,
  },
}
