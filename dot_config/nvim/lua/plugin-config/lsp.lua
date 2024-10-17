-- local lsp_status = require("lsp-status")
local lspconfig = require("lspconfig")
local navic = require("nvim-navic")

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
vim.api.nvim_set_keymap('n', '<leader>ha', '<cmd>lua vim.lsp.buf.hover_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

-- Open diagnostic when on line
--[[ vim.diagnostic.config({ virtual_text = false }) ]]
--[[ vim.api.nvim_create_autocmd("CursorHold", { ]]
--[[     callback = function() ]]
--[[         vim.diagnostic.open_float(nil, { ]]
--[[             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" }, ]]
--[[             focusable = false, ]]
--[[             source = 'always', ]]
--[[             prefix = ' - ', ]]
--[[         }) ]]
--[[     end ]]
--[[ }) ]]
local function on_attach(client, bufnr)
    --  Show navication
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    if client.server_capabilities.documentHighlightProvider then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
    end

    -- lsp_status.on_attach(client)

    -- vim.notify("[" .. client.name .. "] " .. "Language Server Protocol started")
end

local function on_attach_no_fmt(client, bufnr)
    --  Show navication
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    client.server_capabilities.document_formatting = false

    -- lsp_status.on_attach(client)
end

-- Setup capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

function filterMasonServers(servers)
    local masonServers = {}
    for _, server in ipairs(servers) do
        if server.install then
            table.insert(masonServers, server.name)
        end
    end

    return masonServers
end

-- Language servers
-- Debug with print(vim.inspect(vim.lsp.get_active_clients()))
local servers = {
    { name = "astro",                           install = true },
    { name = "bashls",                          install = true },
    { name = "clangd",                          install = true },
    { name = "csharp_ls",                       install = true },
    { name = "dhall_lsp_server",                install = true },
    { name = "docker_compose_language_service", install = true },
    { name = "dockerls",                        install = true },
    { name = "elixirls",                        install = true },
    { name = "emmet_ls",                        install = true },
    { name = "eslint",                          install = true },
    { name = "gleam",                           install = false },
    { name = "gopls",                           install = true },
    { name = "graphql",                         install = true },
    { name = "helm_ls",                         install = true },
    { name = "hls",                             install = true },
    { name = "html",                            install = true },
    { name = "jsonls",                          install = true },
    { name = "jsonnet_ls",                      install = true },
    { name = "lua_ls",                          install = true },
    { name = "marksman",                        install = true },
    { name = "mdx_analyzer",                    install = true },
    { name = "ocamllsp",                        install = true },
    { name = "prismals",                        install = true },
    { name = "pyright",                         install = true },
    { name = "ruby_lsp",                        install = true },
    { name = "ruff_lsp",                        install = true },
    { name = "svelte",                          install = true },
    { name = "tailwindcss",                     install = true },
    { name = "terraformls",                     install = true },
    { name = "texlab",                          install = true },
    { name = "tflint",                          install = true },
    { name = "ts_ls",                           install = true },
    { name = "volar",                           install = true },
    { name = "yamlls",                          install = true },
}

local masonServers = filterMasonServers(servers)

-- User configurations for individual servers
local configs = {
    elixirls = {
        cmd = { "/usr/local/bin/elixir-ls/language_server.sh" },
    },
    hls = {
        filetypes = { 'haskell', 'lhaskell', 'cabal' },
    },
    lua_ls = {
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
    },
    --[[ astro = { ]]
    --[[     init_options = { ]]
    --[[         typescript = vim.fn.stdpath('data') .. "/mason/bin/typescript-language-server" ]]
    --[[     } ]]
    --[[ } ]]
}

-- User configurations for all servers
local config_defaults = {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Setup configurations
for _, lsp in ipairs(servers) do
    local config = configs[lsp.name] or {}
    config = vim.tbl_extend("keep", config, config_defaults)
    lspconfig[lsp.name].setup(config)
end

-- Change diagnostic signs.
local signs = { Error = "󰅚 ", Warn = " ", Hint = "󰌶 ", Info = " " }

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

return masonServers
