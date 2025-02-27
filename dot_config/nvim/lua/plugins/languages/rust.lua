return {
  {
    "mrcjkb/rustaceanvim",
    version = "*",
    ft = { "rust" },
    dependencies = {
      {
        "SmiteshP/nvim-navic",
        dependencies = {
          "neovim/nvim-lspconfig",
        },
      },
    },
    init = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
      local navic = require "nvim-navic"

      local function on_attach(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end

        if client.server_capabilities.documentHighlightProvider then
          vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.format()"
        end

        vim.keymap.set(
          "n",
          "<leader>co",
          "<cmd>lua vim.cmd.RustLsp('openDocs')<CR>",
          { buffer = bufnr, desc = "Open Rust docs" }
        )
      end

      vim.g.rustaceanvim = {
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--", "-D", "clippy::all" },
              },
            },
          },
        },
      }
    end,
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },
}
