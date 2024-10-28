return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local null_ls = require "null-ls"

      null_ls.setup {
        sources = {
          -- Python
          --[[ null_ls.builtins.formatting.black, ]]

          -- Lua
          null_ls.builtins.formatting.stylua,

          -- Fish
          null_ls.builtins.diagnostics.fish,

          -- Shell
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.shellharden,
          --[[ null_ls.builtins.diagnostics.shellcheck, ]]
          --[[ null_ls.builtins.code_actions.shellcheck, ]]

          -- CSS
          null_ls.builtins.formatting.stylelint,
          null_ls.builtins.diagnostics.stylelint,

          -- C/C++
          -- null_ls.builtins.formatting.uncrustify, -- Java and C# too
          null_ls.builtins.diagnostics.cppcheck,

          -- Others
          -- null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.prettier.with {
            extra_filetypes = { "astro" },
          },
          null_ls.builtins.formatting.nginx_beautifier,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.diagnostics.hadolint, -- Dockerfiles
          null_ls.builtins.diagnostics.yamllint.with {
            extra_args = { "-d", os.getenv "HOME" .. "/.config/nvim/.yamllint.yaml" },
          },
          null_ls.builtins.formatting.golines, -- Includes gofmt and goimports
          null_ls.builtins.formatting.mix, -- Elixir
          --[[ null_ls.builtins.diagnostics.vale, ]]
        },
        on_attach = function(client, bufnr)
          if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { async = false }
              end,
            })
          end
        end,
      }
    end,
  },
}
