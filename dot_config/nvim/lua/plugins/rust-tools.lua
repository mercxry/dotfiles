local function on_attach(client, bufnr)
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
end

require("rust-tools").setup({
    server = {
        on_attach = on_attach,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                    extraArgs = { "--", "-D", "clippy::all" },
                },
            },
        },
    },
})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>grd', '<cmd>RustOpenExternalDocs<CR>', opts)
