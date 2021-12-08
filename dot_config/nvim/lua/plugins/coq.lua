vim.cmd[[let g:coq_settings = { 'auto_start': 'shut-up' }]]
-- vim.cmd[[let coq_settings.keymap.manual_complete = '<C-Space>']]

require('coq_3p') {
    { src = "nvimlua", short_name = "nLUA", conf_only = true }
}

