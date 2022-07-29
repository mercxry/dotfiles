-- local lsp_status = require("lsp-status")
local lspconfig = require("lspconfig")

-- lsp_status.register_progress()

-- Keybinds
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

local function on_attach(client, bufnr)
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end

    -- lsp_status.on_attach(client)

    -- vim.notify("[" .. client.name .. "] " .. "Language Server Protocol started")
end

local function on_attach_no_fmt(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    -- lsp_status.on_attach(client)
end

-- Setup capabilities
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

-- Language servers
-- Debug with print(vim.inspect(vim.lsp.get_active_clients()))
local servers = {
    "pyright",
    "tsserver",
    "dockerls",
    "graphql",
    "pyright",
    "svelte",
    "texlab",
    "tflint",
    "yamlls",
    "eslint",
    "gopls",
    "elixirls",
    "html",
    "jsonls",
    "csharp_ls",
    "sumneko_lua",
    "terraformls",
}

-- User configurations for individual servers
local configs = {
    elixirls = {
        cmd = { "/usr/local/bin/elixir-ls/language_server.sh" },
    },
    sumneko_lua = {
        settings = {
            Lua = {
                format = {
                    enable = true,
                    defaultConfig = {
                        indent_style = "space",
                        indent_size = "2",
                    }
                },
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" }
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                }
            }
        },
    }
}

-- User configurations for all servers
local config_defaults = {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Setup configurations
for _, lsp in ipairs(servers) do
    local config = configs[lsp] or {}
    config = vim.tbl_extend("keep", config, config_defaults)
    lspconfig[lsp].setup(config)
end

-- Change diagnostic signs.
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Global config for diagnostic
vim.diagnostic.config({
    underline = false,
    signs = true,
    severity_sort = true,
})

-- lsp_status.config({
--     indicator_errors = 'E',
--     indicator_warnings = 'W',
--     indicator_info = 'i',
--     indicator_hint = '?',
--     indicator_ok = 'Ok',
-- })
