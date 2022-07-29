vim.o.completeopt = "menuone,noinsert,noselect"
-- vim.o.shortmess += 'c'

local cmp = require 'cmp'
local lspkind = require 'lspkind'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    },
    formatting = {
        format = lspkind.cmp_format({ with_text = true, maxwidth = 50 })
    },

    -- Installed sources
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'nvim_lua' },
        { name = 'emoji' },
        { name = 'tmux' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp_document_symbol' },
        { name = 'luasnip' },
    },
})

cmp.setup.cmdline(':', {
    sources = {
        { name = 'cmdline' }
    },
    mapping = cmp.mapping.preset.cmdline({}),
})

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    },
    mapping = cmp.mapping.preset.cmdline({}),
})

cmp.setup.buffer({
    sources = cmp.config.sources({
        { name = 'conventionalcommits' },
        { name = 'buffer' },
    })
})
